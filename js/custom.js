/* Javascript für Beautek Anpassungen */

// Workaround falls zwei Kategorien aktiv sein sollten
if ($(".shop-first-layer-navigation .first-layer-menu-list").length > 0) {
  $navItems = $(
    ".shop-first-layer-navigation .first-layer-menu-list"
  ).children();
  let firstNav = $navItems[0];
  let thirdNav = $navItems[2];
  if (
    firstNav.classList.contains("active") &&
    thirdNav.classList.contains("active")
  ) {
    firstNav.classList.remove("active");
  }
}

$(document).ready(function () {
  if (window.location.href.indexOf("das-wonderlift-behandlungssystem") > -1) {
    $(".nav.nav-tabs.bottom15 li:first a").addClass("active");
    $(".wo_tabs .tab-content div:first").addClass("show");
    $(".wo_tabs_small .nav.nav-tabs.bottom15 li:first a").addClass("active");
    $(".wo_tabs_small .tab-content div:first").addClass("show");
  }
  if (window.location.pathname == "/product") {
    // Replace "/product" with the actual URL of your product page
    $("#image-wrapper").slick({
      autoplay: true,
      arrows: false,
      dots: true,
      infinite: true,
      speed: 500,
      slidesToShow: 1,
      slidesToScroll: 1,
    });
  }

  if (document.body.getAttribute("data-page") === "5") {
    var salutation = document.getElementById("salutation");
    if (salutation) {
      salutation.value = "w";
      salutation.dispatchEvent(new Event("change", { bubbles: true }));
    }
  }
});

function initDetailPreviewSlider() {
  $("#gallery_wrapper")
    .not(".slick-initialized")
    .slick({
      lazyLoad: "ondemand",
      infinite: true,
      dots: true,
      arrows: true,
      speed: 500,
      fade: true,
      cssEase: "linear",
      asNavFor: "#gallery_preview",
      responsive: [
        {
          breakpoint: 992,
          settings: {
            dots: true,
          },
        },
      ],
    });
}

function initGalleryCounter() {
  var $gallery = $("#gallery");
  var $counter = $(".gallery-image-counter .js-gallery-current");

  if ($gallery.length === 0 || $counter.length === 0) {
    return;
  }

  if (!$gallery.data("gallery-counter-bound")) {
    $gallery.on("init afterChange", function (event, slick, currentSlide) {
      var current = (currentSlide || 0) + 1;
      $counter.text(current);
    });
    $gallery.data("gallery-counter-bound", true);
  }

  if ($gallery.hasClass("slick-initialized")) {
    var slick = $gallery.slick("getSlick");
    if (slick) {
      $counter.text((slick.currentSlide || 0) + 1);
    }
  }
}

function getBerlinNowParts() {
  try {
    var dtf = new Intl.DateTimeFormat("de-DE", {
      timeZone: "Europe/Berlin",
      weekday: "short",
      hour: "2-digit",
      minute: "2-digit",
      hour12: false,
    });
    var parts = dtf.formatToParts(new Date());
    var map = {};
    parts.forEach(function (p) {
      map[p.type] = p.value;
    });
    return {
      weekday: (map.weekday || "").toLowerCase(), // "mo.", "di.", ...
      hour: parseInt(map.hour, 10),
      minute: parseInt(map.minute, 10),
    };
  } catch (e) {
    // Fallback: lokale Zeit
    var d = new Date();
    return {
      weekday: ["so.", "mo.", "di.", "mi.", "do.", "fr.", "sa."][d.getDay()],
      hour: d.getHours(),
      minute: d.getMinutes(),
    };
  }
}

function initShippingCutoffText() {
  var $nodes = $(".js-shipping-cutoff");
  if ($nodes.length === 0) return;

  var now = getBerlinNowParts();
  var isWeekday = now.weekday.indexOf("mo") === 0
    || now.weekday.indexOf("di") === 0
    || now.weekday.indexOf("mi") === 0
    || now.weekday.indexOf("do") === 0
    || now.weekday.indexOf("fr") === 0;

  $nodes.each(function () {
    var el = this;
    var cutoffHour = parseInt(el.getAttribute("data-cutoff-hour") || "11", 10);
    var text = el.getAttribute("data-cutoff-text") || "";

    var shouldShow = isWeekday && now.hour >= 0 && now.hour < cutoffHour;

    if (shouldShow && text.length > 0) {
      el.textContent = text;
      el.style.display = "";
    } else {
      el.textContent = "";
      el.style.display = "none";
    }
  });
}

// function initDetailPreviewSlider(){
//   $('#gallery_preview_wrapper .carousel').not('.slick-initialized').slick({
//     lazyLoad: 'ondemand',
//     slidesToShow: 5,
//     slidesToScroll: 1,
//     asNavFor: '#gallery',
//     dots: false,
//     arrows: true,
//     focusOnSelect: true,
//     responsive: [
//         {
//             breakpoint: 768,
//             settings: {
//                 slidesToShow: 4,
//                 slidesToScroll: 1,
//             }
//         },
//         {
//             breakpoint: 576,
//             settings: {
//                 slidesToShow: 3,
//                 slidesToScroll: 1,
//             }
//         }
//     ]
//   });
// }

$(document).ready(function () {
  $(".price_label.price_out_of_stock").closest(".product-wrapper").hide();
  if ($(".list.active")) {
    $(".product-wrapper > div").removeAttr("id");
  }
  initGalleryCounter();
  initShippingCutoffText();
});

// JTL/Evo lädt Inhalte teils dynamisch nach – Cutoff-Text dann erneut setzen
$(document).on("evo:contentLoaded", function () {
  initGalleryCounter();
  initShippingCutoffText();
});

// $(document).on('evo:contentLoaded', function(){
//   initDetailPreviewSlider();
// });

// $( window ).on('resize', function(){
//   initDetailPreviewSlider();
// });

// Function to set a cookie
function setCookie(cname, cvalue, exdays) {
  var d = new Date();
  d.setTime(d.getTime() + exdays * 24 * 60 * 60 * 1000);
  var expires = "expires=" + d.toUTCString();
  document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
}

// Function to get a cookie
function getCookie(cname) {
  var name = cname + "=";
  var ca = document.cookie.split(";");
  for (var i = 0; i < ca.length; i++) {
    var c = ca[i];
    while (c.charAt(0) == " ") {
      c = c.substring(1);
    }
    if (c.indexOf(name) == 0) {
      return c.substring(name.length, c.length);
    }
  }
  return "";
}

function checkBreadcrumbs() {
  listNavLinks = $(".breadcrumb-link", $("#breadcrumb"));
  let foundNav;
  listNavLinks.each(function () {
    breadcrumbInnerHTML = this.innerHTML;

    if (breadcrumbInnerHTML.includes("KOSMETIK")) {
      foundNav = beautyTheme;
    } else if (breadcrumbInnerHTML.includes("FRISEUR")) {
      foundNav = barberTheme;
    } else if (breadcrumbInnerHTML.includes("TATTOO")) {
      foundNav = tattooTheme;
    } else {
      return "undefined";
    }
  });
  return foundNav;
}

beautyTheme = "1563";
barberTheme = "217";
tattooTheme = "1837";

currentURL = window.location.href;

// Check if a cookie exists and set a default value if it doesn't
var themeCode = getCookie("themeCode");
console.log("themeCodeFirst " + themeCode);

// Listen for clicks on the three links in the header

var allLinks = document.querySelectorAll("ul.first-layer-menu-list li");
// let logoLink = document.querySelector('#logo');
let logoLink = document.querySelectorAll(".navbar-brand");

allLinks.forEach(function (link) {
  link.addEventListener("click", function (e) {
    // Update the theme code cookie when a link is clicked

    clickInnerHTML = e.target.innerHTML;

    if (clickInnerHTML.includes("KOSMETIK")) {
      setCookie("themeCode", beautyTheme, 365);
    } else if (clickInnerHTML.includes("FRISEUR")) {
      setCookie("themeCode", barberTheme, 365);
    } else if (clickInnerHTML.includes("TATTOO")) {
      setCookie("themeCode", tattooTheme, 365);
    }

    // Check if the nav with the id "breadcrumb" contains an element with the innerhtml "beauty"
  });
});

logoLink[0].addEventListener("click", function (e) {
  e.preventDefault();

  let currentTheme = getCookie("themeCode");

  if (currentTheme === beautyTheme) {
    window.location.replace("https://www.beautek.de/", "_self");
  } else if (currentTheme === barberTheme) {
    window.location.replace(
      "https://www.beautek.de/friseurstudio-einrichtung",
      "_self"
    );
  } else if (currentTheme === tattooTheme) {
    window.location.replace(
      "https://www.beautek.de/tattoo-studio-einrichtung",
      "_self"
    );
  }
});

// Schaut ob in der URL die folgenden Stichworte enthalten sind. Wichtig um Homepage abzudecken.
if (currentURL.includes("KOSMETIK")) {
  setCookie("themeCode", beautyTheme, 365);
  themeCode = beautyTheme;
} else if (currentURL.includes("FRISEUR")) {
  setCookie("themeCode", barberTheme, 365);
  themeCode = barberTheme;
} else if (currentURL.includes("TATTOO")) {
  setCookie("themeCode", tattooTheme, 365);
  themeCode = tattooTheme;
} else if (themeCode == "" || themeCode == "undefined") {
  themeCode = beautyTheme;
  setCookie("themeCode", themeCode, 365);
}

if (currentURL == "https://www.beautek.de/") {
  setCookie("themeCode", beautyTheme, 365);
  themeCode = beautyTheme;
}

// Checkt die Breadcrumbs der Kategorie Artikeldarstellung
if (document.body.getAttribute("data-page") === "2") {
  //Wichtig dass bei der Produktseite nicht die Breadcrumbs benutzt werden

  let breadcrumb = document.querySelector("#breadcrumb"); //Breadcrumbs werden selektiert
  let breadcrumbscode = checkBreadcrumbs();

  if (breadcrumbscode != undefined) {
    setCookie("themeCode", breadcrumbscode, 365);
    themeCode = breadcrumbscode;
  }
}

// Wenn ein Artikel gewählt wird der einem anderen Bereich zugeordnet ist, soll der Active Navigation Link trotzdem auf den eigentlichen Bereich zeigen (e.g Lemi Liege im Bereich Medizin, Active Nav Link ist auf Beauty soll aber auf Medizin zeigen)
if (document.body.getAttribute("data-page") === "1") {
  //Nur Aktiv bei Produktseite

  allLinks.forEach(function (obj) {
    nameNavObject = obj.innerHTML;
    obj.classList.remove("active");
    if (nameNavObject.includes("KOSMETIK") && themeCode === beautyTheme) {
      obj.classList.add("active");
    } else if (nameNavObject.includes("FRISEUR") && themeCode === barberTheme) {
      obj.classList.add("active");
    } else if (nameNavObject.includes("TATTOO") && themeCode === tattooTheme) {
      obj.classList.add("active");
    }
  });
}

console.log(themeCode);
document.body.setAttribute("color-theme", themeCode);

//#endregion

// Bestellvorgang Coupon accordion
$("#panel-edit-coupon .card-header").click(function () {
  $("#panel-edit-coupon").toggleClass("active");
});

// Warenkorb Auswahl

setTimeout(function () {
  if (currentURL.toLowerCase().includes("bestellvorgang")) {
    let checkoutRadios = document.querySelectorAll(
      ".checkout-payment-method .custom-control-input"
    );
    let checkoutOptions = document.querySelectorAll(
      ".ppc-checkout-payment-method"
    );
    console.log(checkoutOptions);

    let firstRadioParent = checkoutRadios[0].parentElement.parentElement;
    firstRadioParent.classList.add("selected");
    firstRadioParent.style.padding = "1rem 0";
    checkoutRadios[0].checked = true; // Check the first radio button

    checkoutRadios.forEach(function (element) {
      element.addEventListener("click", function (e) {
        console.log(e.target);
        if (e.target) {
          let borderElement = e.target.parentElement.parentElement;
          borderElement.classList.add("selected");
          borderElement.style.padding = "1rem 0";

          let checkoutRadiosListener = document.querySelectorAll(
            ".checkout-payment-method .custom-control-input"
          );
          console.log(checkoutRadiosListener);
          checkoutRadiosListener.forEach(function (radio) {
            if (!radio.checked) {
              let uncheckedElement = radio.parentElement.parentElement;
              uncheckedElement.classList.remove("selected");
              uncheckedElement.style.padding = "0";
            }
          });
        }
      });
    });

    // Add event listener for elements with the class "mondu-payment-method-groups" click
    let monduPaymentGroups = document.querySelectorAll(
      ".mondu-payment-method-groups"
    );
    monduPaymentGroups.forEach(function (group) {
      group.addEventListener("click", function () {
        let selectedElements = document.querySelectorAll(".selected");
        selectedElements.forEach(function (element) {
          element.classList.remove("selected");
          element.style.padding = "0";
        });
      });
    });
  }
}, 2000);

console.log(document.querySelector(".input-group-prepend button"));
let quantity = document.getElementById("quantity");
// console.log(quantity.value);

$(document).ready(function () {
  document.querySelectorAll(".input-group-prepend").forEach(function (prepend) {
    prepend.addEventListener("click", function () {
      let quantity = document.getElementById("quantity");

      let quantityAdaptive = document.getElementById(
        "quantity_adaptive-configurator"
      );
      let input = this.nextElementSibling;
      if (input.id === "quantity") {
        quantityAdaptive.value = quantity.value;
      } else if (input.id === "quantity_adaptive-configurator") {
        quantity.value = input.value;
      }
    });
  });

  document.querySelectorAll(".input-group-append").forEach(function (append) {
    append.addEventListener("click", function () {
      console.log("funktioniert");
      let quantity = document.getElementById("quantity");

      let quantityAdaptive = document.getElementById(
        "quantity_adaptive-configurator"
      );

      let input = this.previousElementSibling;
      console.log(input);
      if (input.id === "quantity") {
        quantityAdaptive.value = quantity.value;
      } else if (input.id === "quantity_adaptive-configurator") {
        quantity.value = input.value;
      }
    });
  });
});

$('body').on('click','.custom-accordion .panel-heading',function(){
	var accGroup = $(this).next(".panel-body");
	$(this).closest(".custom-accordion").toggleClass("active");
	accGroup.toggleClass("active");
});
/*
const configClick = () => {
	console.log("configClick");
	$(".custom-accordion .panel-heading").each((index,panel) => {
		console.log($(panel));
		if(!$(panel).hasClass("init")){
			console.log("addListerner");
			$(panel).addClass('init');
			$('body').on("click",panel, function () {
				var accGroup = $(this).next(".panel-body");
				$(this).closest(".custom-accordion").toggleClass("active");
				accGroup.toggleClass("active");
			});
		}
	})
};
*/
const additionalPanel = () => {
  $(document).ready(function () {
    // Select the container element
    var $container = $("#additional-supplies");

    // Check if there is a .panel-heading child within the container
    var $panelHeading = $container.find(".panel-heading");

    // If .panel-heading is not found, set the display property to none
    if ($panelHeading.length === 0) {
      $container.css("display", "none");
    }
  });
};

//Bugfix Accordion when ajax reload (variationchange)
const dynamicReloadVariationEventListener = () => {
	$('label.variation.swatches input').each((index,variationInput) => {
		variationInput.addEventListener("change", () => {
			//configClick();
			additionalPanel();
		});
	});
}

let counter = 0;

// Call the function
$(document).ready(function () {
	console.log("ready");
	//configClick();
	additionalPanel();
	dynamicReloadVariationEventListener();
});



$(document).ajaxComplete(function(event, xhr, settings) {
	console.log("ajax");
    if (xhr.hasOwnProperty('responseJSON')) {
		if(xhr.responseJSON.hasOwnProperty('evoProductCalls')){
			if(searchInMultiDim(xhr.responseJSON.evoProductCalls,'variationRefreshAll')){
				// Accordion läuft über delegated $('body').on('click', '.custom-accordion .panel-heading', ...)
				additionalPanel();
				dynamicReloadVariationEventListener();
        initGalleryCounter();
        initShippingCutoffText();
			}
		}
    }
});

function searchInMultiDim(arr,str) {
	let includes = false;
	arr.some((item, index)=>{
		if(Array.isArray(item)){
			if(searchInMultiDim(item,str)){
				includes = true;
				return true;
			}
		}
		else{
			if(str == item){
				includes = true;
				return true;
			}
		}
	})
	return includes;
}

/* Mini-Warenkorb: Sidebar + Mengenänderung (v6) */
(function ($) {
  var cartSidebarUpdateTimer;
  var cartSidebarSubmitting = false;
  var cartSidebarQtyLock = false;
  var cartSidebarLastQtyBtnAt = 0;
  var cartSidebarIoContext = {};
  var cartSidebarRefreshInFlight = false;
  var cartSidebarSyncTimer = null;
  var cartSidebarSkipNextContentLoadedSync = false;

  function markBasketPage() {
    if (document.querySelector(".container.basket")) {
      document.body.classList.add("is-basket-page");
    }
  }

  function isCartSidebarContext() {
    return $(".cart-icon-dropdown").length > 0;
  }

  function isBasketPage() {
    return document.body.classList.contains("is-basket-page");
  }

  function syncBasketPageAfterSidebarUpdate() {
    if (!isBasketPage()) {
      return;
    }
    if ($.evo && $.evo.basket && typeof $.evo.basket().updateCart === "function") {
      $.evo.basket().updateCart();
    }
  }

  function closeCartSidebar() {
    document.body.classList.remove("cart-sidebar-open");
    $("#cart-sidebar-backdrop").remove();
    removeNavDropdownBackdrop();
  }

  function removeNavDropdownBackdrop() {
    if ($("#mainNavigation").hasClass("show")) {
      return;
    }
    $(".modal-backdrop").removeClass("show zindex-dropdown").hide();
    window.setTimeout(function () {
      if (!$(".nav-right .dropdown.show").length && !$("#mainNavigation").hasClass("show")) {
        $(".modal-backdrop").detach();
      }
    }, 0);
  }

  function closeCartSidebarDropdown() {
    var $dropdown = $(".cart-icon-dropdown").filter(function () {
      return (
        $(this).hasClass("show") || $(this).find(".cart-dropdown").hasClass("show")
      );
    }).first();

    if (
      !$dropdown.length &&
      document.body.classList.contains("cart-sidebar-open")
    ) {
      $dropdown = $(".cart-icon-dropdown").first();
    }

    if (!$dropdown.length) {
      closeCartSidebar();
      return;
    }

    var $toggle = $dropdown.find('[data-toggle="dropdown"]').first();
    if ($toggle.length && typeof $toggle.dropdown === "function") {
      try {
        $toggle.dropdown("hide");
        return;
      } catch (ignore) {}
    }

    $dropdown.removeClass("show");
    $dropdown.find(".cart-dropdown").removeClass("show");
    $toggle.attr("aria-expanded", "false");
    closeCartSidebar();
  }

  function openCartSidebarDropdown() {
    var $dropdown = $(".cart-icon-dropdown").first();
    if (!$dropdown.length) {
      return;
    }

    prepareCartSidebarMenu($dropdown.find(".cart-dropdown"));

    var $toggle = $dropdown.find('[data-toggle="dropdown"]').first();
    if ($toggle.length && typeof $toggle.dropdown === "function") {
      try {
        $toggle.dropdown("show");
        return;
      } catch (ignore) {}
    }

    $dropdown.addClass("show");
    $dropdown.find(".cart-dropdown").addClass("show");
    if ($toggle.length) {
      $toggle.attr("aria-expanded", "true");
    }
    document.body.classList.add("cart-sidebar-open");
  }

  function showCartSidebarSuccess(message) {
    var msg =
      message ||
      window.__beautekCartSuccessMsg ||
      "Dieser Artikel befindet sich nun in Ihrem Warenkorb.";
    var $menu = $(".cart-icon-dropdown .cart-dropdown").first();
    if (!$menu.length) {
      return;
    }

    $menu.find(".cart-sidebar-success").remove();
    var $notice = $(
      '<div class="cart-sidebar-success" role="status"></div>'
    ).text(msg);

    var $form = $menu.find("#cart-sidebar-form").first();
    if ($form.length) {
      $form.prepend($notice);
    } else {
      var $items = $menu.find(".dropdown-cart-items, .table-responsive").first();
      if ($items.length) {
        $items.before($notice);
      } else {
        $menu.prepend($notice);
      }
    }

    window.setTimeout(function () {
      $menu.find(".cart-sidebar-success").fadeOut(400, function () {
        $(this).remove();
      });
    }, 6000);
  }

  function revealCartSidebarAfterAdd() {
    initCartSidebarUi($(".cart-icon-dropdown"));
    showCartSidebarSuccess(window.__beautekCartSuccessMsg);
    openCartSidebarDropdown();
    window.__beautekOpenSidebarAfterCart = false;
  }

  var cartSidebarLockingStyles = false;

  function prepareCartSidebarMenu($menu) {
    if (!$menu.length || cartSidebarLockingStyles) {
      return;
    }

    // Popper/Bootstrap-Inline-Styles komplett entfernen – sonst flackert die
    // fixe Sidebar bei Hover auf Links/Buttons (Artikelnamen, Weiter einkaufen).
    var el = $menu.get(0);
    if (!el) {
      return;
    }

    cartSidebarLockingStyles = true;
    try {
      el.removeAttribute("style");
      el.style.setProperty("position", "fixed", "important");
      el.style.setProperty("top", "0", "important");
      el.style.setProperty("right", "0", "important");
      el.style.setProperty("bottom", "0", "important");
      el.style.setProperty("left", "auto", "important");
      el.style.setProperty("transform", "translateX(0)", "important");
      el.style.setProperty("margin", "0", "important");
      el.style.setProperty("will-change", "auto", "important");

      $menu.removeAttr("x-placement");
      $menu.removeAttr("data-popper-reference-hidden");
      $menu.removeAttr("data-popper-escaped");
      $menu.addClass("cart-sidebar-locked");
    } finally {
      window.setTimeout(function () {
        cartSidebarLockingStyles = false;
      }, 0);
    }
  }

  function lockCartSidebarToggle($root) {
    var $scope = $root && $root.length ? $root : $(".cart-icon-dropdown");
    $scope
      .find('[data-toggle="dropdown"]')
      .attr("data-display", "static")
      .data("display", "static");
  }

  function cartDropdownHasPopperStyles(el) {
    if (!el) {
      return false;
    }
    if (el.hasAttribute("x-placement")) {
      return true;
    }
    var style = el.getAttribute("style") || "";
    if (!style) {
      return false;
    }
    return (
      style.indexOf("translate3d") !== -1 ||
      /(?:^|;)\s*top\s*:\s*(?!0(?:px|%)?\s*(?:;|$))/.test(style) ||
      /(?:^|;)\s*left\s*:\s*(?!auto\s*(?:;|$))/.test(style)
    );
  }

  function ensureCloseButton($menu) {
    if (!$menu.length || $menu.find(".cart-sidebar-close").length) {
      return;
    }
    var $btn = $(
      '<button type="button" class="cart-sidebar-close" aria-label="Warenkorb schließen">&times;</button>'
    );
    $menu.prepend($btn);
  }

  function hasLivePayPalInBody($body) {
    return (
      $body.find(
        'iframe[src*="paypal"], .paypal-buttons, .paypal-button, [id*="paypal-button"], [id*="zoid-paypal"]'
      ).length > 0
    );
  }

  function isPayPalInjectedNode($el) {
    if (!$el || !$el.length) {
      return false;
    }

    if (
      $el.is(
        '.trigger[data-consent], [id*="ppc-"], [id*="paypal"], .paypal-buttons, .paypal-button, [id*="zoid-paypal"]'
      )
    ) {
      return true;
    }

    return (
      $el.find(
        '[id*="ppc-"], [id*="paypal"], .paypal-buttons, .paypal-button, [id*="zoid-paypal"]'
      ).length > 0
    );
  }

  function isGlobalPayPalTarget(target) {
    if (!target) {
      return false;
    }

    return (
      $(target).closest(
        '[id*="ppc-"], [id*="paypal"], .paypal-buttons, .paypal-button, [id*="zoid-paypal"], iframe[src*="paypal"]'
      ).length > 0
    );
  }

  function unwrapSidebarPayPalConsent($root) {
    var $scope = $root && $root.length ? $root : $(".cart-icon-dropdown");
    var $body = $scope.find(".dropdown-body").first();
    if (!$body.length) {
      return;
    }

    $body.find(".trigger[data-consent]").each(function () {
      var $trigger = $(this);
      var key = String($trigger.attr("data-consent") || "").toLowerCase();

      if (key && /youtube|vimeo|video|maps|google/.test(key)) {
        return;
      }

      $trigger.children().appendTo($trigger.parent());
      $trigger.remove();
    });

    $body.find(".consent-hidden").removeClass("consent-hidden");
  }

  function sidebarHasPayPal($body) {
    return (
      $body.find('[id*="ppc"], .paypal-buttons, .paypal-button, [id*="zoid-paypal"]').length > 0
    );
  }

  function cartSidebarFormSignature($form) {
    if (!$form || !$form.length) {
      return "";
    }
    var parts = [];
    $form.find('input.quantity[name^="anzahl["]').each(function () {
      parts.push(this.name + "=" + String(this.value));
    });
    $form.find(".cart-sidebar-line-total-price").each(function () {
      parts.push($(this).text().replace(/\s+/g, " ").trim());
    });
    parts.push(String($form.find(".cart-sidebar-item").length));
    return parts.join("|");
  }

  function patchCartSidebarBody($oldBody, $newBody) {
    if (!$oldBody.length || !$newBody.length) {
      return;
    }

    var $oldTotals = $oldBody.children("ul.list-unstyled").first();
    var $newTotals = $newBody.children("ul.list-unstyled").first();
    if ($newTotals.length) {
      if ($oldTotals.length) {
        if ($oldTotals.html() !== $newTotals.html()) {
          $oldTotals.replaceWith($newTotals.clone());
        }
      } else {
        $oldBody.prepend($newTotals.clone());
      }
    } else if ($oldTotals.length) {
      $oldTotals.remove();
    }

    var $oldButtons = $oldBody.find(".cart-dropdown-buttons").first();
    var $newButtons = $newBody.find(".cart-dropdown-buttons").first();
    if ($newButtons.length) {
      if ($oldButtons.length) {
        // Buttons nicht dauernd ersetzen – sonst Blinken / Klicks unmöglich
        if (
          !$oldButtons.find(".cart-sidebar-continue, .cart-dropdown-continue").length ||
          $oldButtons.find("a[href*='warenkorb'], a[href*='Warenkorb']").length !==
            $newButtons.find("a[href*='warenkorb'], a[href*='Warenkorb']").length
        ) {
          $oldButtons.replaceWith($newButtons.clone(true));
        }
      } else {
        $oldBody.append($newButtons.clone(true));
      }
    }

    $oldBody.find(".cart-dropdown-shipping-notice").remove();
    $newBody.find(".cart-dropdown-shipping-notice").each(function () {
      $oldBody.append($(this).clone());
    });

    $oldBody.find("hr").remove();
    $newBody.children("hr").each(function () {
      $oldBody.append($(this).clone());
    });

    // PayPal nur nachrüsten, wenn noch keins da ist. Bestehende Buttons NICHT
    // ersetzen – sonst schlägt die Plugin-Re-Init fehl ("Bitte prüfen Sie alle
    // Eingaben").
    if (!sidebarHasPayPal($oldBody)) {
      $newBody.children().each(function () {
        var $child = $(this).clone(true);
        if (isPayPalInjectedNode($child)) {
          var $wrap = $child.find(".trigger[data-consent]").first();
          if ($wrap.length) {
            $wrap.children().appendTo($child);
            $wrap.remove();
          }
          $child.find(".consent-hidden").removeClass("consent-hidden");
          $oldBody.append($child);
        }
      });
      reinitCartSidebarPlugins($oldBody.closest(".cart-icon-dropdown"));
    }
  }

  function updateCartSidebarChrome($current, $new) {
    var $newBadge = $new.find(".fa-sup");
    var $oldBadge = $current.find(".fa-sup");
    if ($newBadge.length) {
      if ($oldBadge.length) {
        $oldBadge.replaceWith($newBadge.clone());
      } else {
        $current.find(".cart-icon-dropdown-icon").append($newBadge.clone());
      }
    } else {
      $oldBadge.remove();
    }

    $current.toggleClass("not-empty", $new.hasClass("not-empty"));

    var $newPrice = $new.find(".cart-icon-dropdown-price");
    var $oldPrice = $current.find(".cart-icon-dropdown-price");
    if ($newPrice.length && $oldPrice.length) {
      $oldPrice.text($newPrice.text());
    } else if ($newPrice.length) {
      $current.find(".nav-link").append($newPrice.clone());
    } else {
      $oldPrice.remove();
    }
  }

  function reinitCartSidebarPlugins($root) {
    window.setTimeout(function () {
      var $scope = $root && $root.length ? $root : $(".cart-icon-dropdown");

      unwrapSidebarPayPalConsent($scope);

      // Eigenen Sync überspringen – sonst: contentLoaded → sync → refresh → Loop/Blinken
      cartSidebarSkipNextContentLoadedSync = true;
      $(document).trigger("evo:contentLoaded");

      var ppcHooks = [
        window.ppcInitButtons,
        window.initPayPalButtons,
        window.PPC && window.PPC.init,
        window.jtlPayPal && window.jtlPayPal.init,
      ];
      ppcHooks.forEach(function (fn) {
        if (typeof fn === "function") {
          try {
            fn();
          } catch (ignore) {}
        }
      });

      initCartSidebarUi($scope);
    }, 100);
  }

  function initCartSidebarUi($root) {
    var $scope = $root && $root.length ? $root : $(document);
    $scope.find(".cart-dropdown").each(function () {
      ensureCloseButton($(this));
      prepareCartSidebarMenu($(this));
    });
  }

  document.addEventListener(
    "submit",
    function (e) {
      var form = e.target;
      if (!form || form.id !== "cart-sidebar-form") {
        return;
      }

      var submitter = e.submitter || (e.originalEvent && e.originalEvent.submitter);

      e.preventDefault();
      e.stopImmediatePropagation();

      if (submitter && submitter.name === "dropPos") {
        removeCartSidebarPosition($(form), submitter.value);
      } else {
        submitCartSidebarForm($(form));
      }
    },
    true
  );

  function parseQuantityInputName(name) {
    var match = (name || "").match(/^anzahl\[(\d+)\]$/);
    return match ? match[1] : null;
  }

  function buildCartSidebarPostData($form, dropIndex) {
    var data = [];

    $form.serializeArray().forEach(function (item) {
      if (
        dropIndex !== undefined &&
        dropIndex !== null &&
        item.name === "anzahl[" + dropIndex + "]"
      ) {
        return;
      }
      data.push(item);
    });

    if (dropIndex !== undefined && dropIndex !== null) {
      data.push({ name: "dropPos", value: String(dropIndex) });
    }

    return data;
  }

  var cartSidebarLastDeleteAt = 0;

  function getCartSidebarDeleteIndex($button) {
    if (!$button || !$button.length) {
      return null;
    }

    var value = $button.val();
    if (value !== undefined && value !== null && String(value).length > 0) {
      return value;
    }

    return $button.attr("value");
  }

  function refreshCartSidebarFallback(keepOpen) {
    if ($.evo && $.evo.basket && typeof $.evo.basket().updateCart === "function") {
      $.evo.basket().updateCart();
    }

    if (!keepOpen) {
      return;
    }

    window.setTimeout(function () {
      refreshCartSidebar(true);
    }, 250);
  }

  function removeCartSidebarPosition($form, positionIndex) {
    if (
      !$form.length ||
      cartSidebarSubmitting ||
      positionIndex === null ||
      positionIndex === undefined ||
      !isCartSidebarContext()
    ) {
      return false;
    }

    cartSidebarSubmitting = true;
    $form.addClass("cart-sidebar-loading");

    $.post($form.attr("action"), $.param(buildCartSidebarPostData($form, positionIndex)))
      .always(function () {
        cartSidebarSubmitting = false;
        $form.removeClass("cart-sidebar-loading");
      })
      .done(function () {
        var keepOpen = document.body.classList.contains("cart-sidebar-open");
        if ($.evo && $.evo.basket && typeof $.evo.basket().updateCart === "function") {
          $.evo.basket().updateCart();
        }
        window.setTimeout(function () {
          refreshCartSidebar(keepOpen);
          syncBasketPageAfterSidebarUpdate();
        }, 80);
      })
      .fail(function () {
        if ($.evo && $.evo.basket) {
          $.evo.basket().updateCart();
        }
      });

    return true;
  }

  function getQuantityStep(input) {
    if (!input) {
      return 1;
    }
    if (input.step && input.step !== "any") {
      var step = parseFloat(String(input.step).replace(",", "."));
      if (!isNaN(step) && step > 0) {
        return step;
      }
    }
    return 1;
  }

  function setQuantityValue($input, value) {
    var input = $input.get(0);
    if (!input) {
      return;
    }
    var decimals = parseInt($input.data("decimals"), 10);
    if (isNaN(decimals)) {
      decimals = 0;
    }
    input.value = Number(value).toFixed(decimals);
  }

  function adjustSidebarQuantity($button, increase) {
    if (cartSidebarQtyLock) {
      return false;
    }

    var $input = $button.closest(".form-counter").find("input.quantity");
    var input = $input.get(0);
    if (!input) {
      return false;
    }

    cartSidebarQtyLock = true;

    var min = parseFloat(input.min);
    if (isNaN(min)) {
      min = 0;
    }
    var max = parseFloat(input.max);
    var step = getQuantityStep(input);
    var current = parseFloat(String(input.value).replace(",", "."));
    if (isNaN(current)) {
      current = min || step;
    }
    var positionIndex = parseQuantityInputName($input.attr("name"));
    var $form = $button.closest("#cart-sidebar-form");
    var newValue = increase ? current + step : current - step;

    if (!increase && (newValue <= 0 || (newValue < min && min <= 1))) {
      cartSidebarQtyLock = false;
      if (positionIndex !== null && $form.length) {
        window.clearTimeout(cartSidebarUpdateTimer);
        return removeCartSidebarPosition($form, positionIndex);
      }
      return false;
    }

    if (!increase && newValue < min) {
      newValue = min;
    }

    if (!isNaN(max) && newValue > max) {
      cartSidebarQtyLock = false;
      return false;
    }

    setQuantityValue($input, newValue);
    window.setTimeout(function () {
      cartSidebarQtyLock = false;
    }, 350);

    return false;
  }

  function handleCartSidebarQtyButton(e, increase) {
    var now = Date.now();
    if (now - cartSidebarLastQtyBtnAt < 450) {
      e.preventDefault();
      e.stopPropagation();
      return;
    }
    cartSidebarLastQtyBtnAt = now;

    e.preventDefault();
    e.stopPropagation();

    var removed = adjustSidebarQuantity($(this), increase);
    if (!removed) {
      scheduleCartSidebarUpdate();
    }
  }

  function scheduleCartSidebarUpdate() {
    window.clearTimeout(cartSidebarUpdateTimer);
    cartSidebarUpdateTimer = window.setTimeout(function () {
      submitCartSidebarForm($("#cart-sidebar-form"));
    }, 500);
  }

  function syncCartSidebarFromServer() {
    if (!isCartSidebarContext()) {
      return;
    }

    window.clearTimeout(cartSidebarSyncTimer);
    cartSidebarSyncTimer = window.setTimeout(function () {
      if (!$.evo || !$.evo.io) {
        return;
      }
      if (cartSidebarRefreshInFlight || cartSidebarSubmitting) {
        return;
      }
      // Frischen Warenkorb vom Server holen. Sidebar zu: nur Artikelliste
      // aktualisieren, Footer (PayPal) unangetastet lassen – wie früher.
      var keepOpen = document.body.classList.contains("cart-sidebar-open");
      refreshCartSidebar(keepOpen, { itemsOnly: !keepOpen });
    }, 80);
  }

  function patchCartSidebar($oldDropdown, $newDropdown, scrollTop) {
    var $oldMenu = $oldDropdown.find(".cart-dropdown");
    var $newMenu = $newDropdown.find(".cart-dropdown");

    if (!$oldMenu.length || !$newMenu.length) {
      $oldDropdown.replaceWith($newDropdown);
      unwrapSidebarPayPalConsent($newDropdown);
      initCartSidebarUi($newDropdown);
      return;
    }

    document.body.classList.add("cart-sidebar-updating");

    var $oldForm = $oldMenu.find("#cart-sidebar-form");
    var $newForm = $newMenu.find("#cart-sidebar-form");
    if ($oldForm.length && $newForm.length) {
      // Formular nur tauschen, wenn Inhalt wirklich anders – sonst Bild-/Button-Blinken
      if (cartSidebarFormSignature($oldForm) !== cartSidebarFormSignature($newForm)) {
        $oldForm.replaceWith($newForm.clone(true));
      }
    } else if (!$oldForm.length && $newForm.length) {
      $oldMenu.prepend($newForm.clone(true));
    }

    var $oldBody = $oldMenu.find(".dropdown-body").first();
    var $newBody = $newMenu.find(".dropdown-body").first();
    if ($oldBody.length && $newBody.length) {
      patchCartSidebarBody($oldBody, $newBody);
    } else if (!$oldBody.length && $newBody.length) {
      $oldMenu.append($newBody.clone(true));
    }

    initCartSidebarUi($oldDropdown);
    $oldDropdown.addClass("show");
    $oldMenu.addClass("show");
    $oldDropdown.find('[data-toggle="dropdown"]').attr("aria-expanded", "true");

    if (typeof scrollTop === "number") {
      $oldDropdown
        .find(".cart-dropdown .table-responsive")
        .scrollTop(scrollTop);
    }

    window.requestAnimationFrame(function () {
      document.body.classList.remove("cart-sidebar-updating");
    });
  }

  function refreshCartSidebar(keepOpen, options) {
    options = options || {};
    var itemsOnly = options.itemsOnly === true;

    if (!isCartSidebarContext() || !$.evo || !$.evo.io) {
      return;
    }

    if (cartSidebarRefreshInFlight) {
      return;
    }

    var $old = $(".cart-icon-dropdown");
    if (!$old.length) {
      return;
    }

    var wasOpen =
      keepOpen &&
      (document.body.classList.contains("cart-sidebar-open") ||
        $old.hasClass("show"));
    var scrollTop = wasOpen
      ? $old.find(".cart-dropdown .table-responsive").scrollTop()
      : 0;

    cartSidebarRefreshInFlight = true;
    cartSidebarIoContext = {};

    $.evo.io().call(
      "getBasketItems",
      [0],
      cartSidebarIoContext,
      function (error, data) {
        cartSidebarRefreshInFlight = false;

        if (
          error ||
          !data ||
          !data.response ||
          !data.response.cTemplate
        ) {
          refreshCartSidebarFallback(keepOpen);
          return;
        }

        var $current = $(".cart-icon-dropdown");
        if (!$current.length) {
          return;
        }

        var $new = $(data.response.cTemplate);

        if (itemsOnly && !wasOpen) {
          updateCartSidebarChrome($current, $new);

          var $oldForm = $current.find("#cart-sidebar-form");
          var $newForm = $new.find("#cart-sidebar-form");
          if ($oldForm.length && $newForm.length) {
            if (
              cartSidebarFormSignature($oldForm) !==
              cartSidebarFormSignature($newForm)
            ) {
              $oldForm.replaceWith($newForm.clone(true));
            }
          }

          var $oldBody = $current.find(".dropdown-body").first();
          var $newBody = $new.find(".dropdown-body").first();
          if ($oldBody.length && $newBody.length) {
            patchCartSidebarBody($oldBody, $newBody);
          }

          unwrapSidebarPayPalConsent($current);
          initCartSidebarUi($current);
          return;
        }

        if (wasOpen) {
          updateCartSidebarChrome($current, $new);

          $current.addClass("show");
          document.body.classList.add("cart-sidebar-open");
          patchCartSidebar($current, $new, scrollTop);
          return;
        }

        $current.replaceWith($new);
        unwrapSidebarPayPalConsent($new);
        initCartSidebarUi($new);
        reinitCartSidebarPlugins($new);
      }
    );
  }

  function submitCartSidebarForm($form) {
    if (
      !$form.length ||
      cartSidebarSubmitting ||
      !isCartSidebarContext()
    ) {
      return;
    }

    var zeroIndex = null;
    $form.find('input.quantity[name^="anzahl["]').each(function () {
      var positionIndex = parseQuantityInputName(this.name);
      var value = parseFloat(String(this.value).replace(",", "."));
      if (positionIndex !== null && (isNaN(value) || value <= 0)) {
        zeroIndex = positionIndex;
        return false;
      }
    });

    if (zeroIndex !== null) {
      removeCartSidebarPosition($form, zeroIndex);
      return;
    }

    cartSidebarSubmitting = true;
    var keepOpen = document.body.classList.contains("cart-sidebar-open");
    $form.addClass("cart-sidebar-loading");

    $.post($form.attr("action"), $form.serialize())
      .always(function () {
        cartSidebarSubmitting = false;
        $form.removeClass("cart-sidebar-loading");
      })
      .done(function () {
        window.setTimeout(function () {
          refreshCartSidebar(keepOpen);
          syncBasketPageAfterSidebarUpdate();
        }, 120);
      })
      .fail(function () {
        if ($.evo && $.evo.basket) {
          $.evo.basket().updateCart();
        }
      });
  }

  $(function () {
    markBasketPage();
    $("#cart-sidebar-backdrop").remove();
    lockCartSidebarToggle($(".cart-icon-dropdown"));
    unwrapSidebarPayPalConsent($(".cart-icon-dropdown"));
    initCartSidebarUi($(".cart-icon-dropdown"));

    // Basket-Factory patchen: statt Notify-Popup Sidebar + Meldung
    (function patchBasketAddFeedback() {
      var tries = 0;
      function attempt() {
        if (!$.evo || typeof $.evo.basket !== "function") {
          if (tries++ < 40) {
            window.setTimeout(attempt, 100);
          }
          return;
        }
        if ($.evo.basket.__beautekPatched) {
          return;
        }
        var originalFactory = $.evo.basket;
        $.evo.basket = function () {
          var basket = originalFactory.apply(this, arguments);
          if (basket && !basket.__beautekPushedPatched) {
            basket.pushedToBasket = function (response) {
              var raw =
                (response && (response.cNotification || response.cLabel)) ||
                "Dieser Artikel befindet sich nun in Ihrem Warenkorb.";
              window.__beautekCartSuccessMsg = $("<div/>").html(raw).text();
              window.__beautekOpenSidebarAfterCart = true;
            };
            if (typeof basket.updateCart === "function") {
              var originalUpdateCart = basket.updateCart.bind(basket);
              basket.updateCart = function (type) {
                // Offene Sidebar: sanft patchen statt komplett ersetzen (Blinken)
                if (
                  document.body.classList.contains("cart-sidebar-open") ||
                  $(".cart-icon-dropdown.show").length
                ) {
                  refreshCartSidebar(true);
                  return;
                }
                return originalUpdateCart(type);
              };
            }
            basket.__beautekPushedPatched = true;
          }
          return basket;
        };
        $.evo.basket.__beautekPatched = true;
      }
      attempt();
    })();

    if (window.__beautekCartJustAdded) {
      window.__beautekOpenSidebarAfterCart = true;
      window.setTimeout(function () {
        refreshCartSidebar(true);
        window.setTimeout(revealCartSidebarAfterAdd, 200);
      }, 150);
    }

    $(document).on("click", ".cart-sidebar-continue", function (e) {
      e.preventDefault();
      e.stopPropagation();
      closeCartSidebarDropdown();
    });

    $(document).on("show.bs.dropdown", ".cart-icon-dropdown", function () {
      if (!isCartSidebarContext()) {
        return;
      }
      lockCartSidebarToggle($(this));
      prepareCartSidebarMenu($(this).find(".cart-dropdown"));
      window.setTimeout(removeNavDropdownBackdrop, 0);
      window.setTimeout(removeNavDropdownBackdrop, 50);
    });

    $(document).on("shown.bs.dropdown", ".cart-icon-dropdown", function () {
      if (!isCartSidebarContext()) {
        return;
      }
      lockCartSidebarToggle($(this));
      prepareCartSidebarMenu($(this).find(".cart-dropdown"));
      document.body.classList.add("cart-sidebar-open");
      removeNavDropdownBackdrop();
      // Popper-Styles ggf. nachträglich nochmal entfernen
      window.setTimeout(function () {
        prepareCartSidebarMenu($(".cart-icon-dropdown .cart-dropdown"));
      }, 0);
    });

    // Falls Popper trotzdem Inline-Styles setzt: nur dann zurücksetzen (kein Loop)
    if (window.MutationObserver) {
      var cartSidebarStyleObserver = new MutationObserver(function (mutations) {
        if (
          cartSidebarLockingStyles ||
          !document.body.classList.contains("cart-sidebar-open")
        ) {
          return;
        }
        mutations.forEach(function (m) {
          if (
            m.type === "attributes" &&
            m.attributeName === "style" &&
            m.target &&
            m.target.classList &&
            m.target.classList.contains("cart-dropdown") &&
            cartDropdownHasPopperStyles(m.target)
          ) {
            prepareCartSidebarMenu($(m.target));
          }
        });
      });
      cartSidebarStyleObserver.observe(document.body, {
        subtree: true,
        attributes: true,
        attributeFilter: ["style", "x-placement"],
      });
    }

    function handleCartSidebarOutside(e) {
      if (!document.body.classList.contains("cart-sidebar-open")) {
        return;
      }
      var $open = $(".cart-icon-dropdown.show");
      if (!$open.length && document.body.classList.contains("cart-sidebar-open")) {
        $open = $(".cart-icon-dropdown");
      }
      if (!$open.length) {
        return;
      }
      var $menu = $open.find(".cart-dropdown");
      var $toggle = $open.find('[data-toggle="dropdown"]');
      if (isGlobalPayPalTarget(e.target)) {
        return;
      }
      if ($menu.is(e.target) || $menu.has(e.target).length) {
        return;
      }
      if ($toggle.is(e.target) || $toggle.has(e.target).length) {
        return;
      }
      closeCartSidebarDropdown();
    }

    $(document).on("click.cartSidebarOutside touchend.cartSidebarOutside", handleCartSidebarOutside);

    $(document).on("hidden.bs.dropdown", ".cart-icon-dropdown", function () {
      closeCartSidebar();
    });

    $(document).on("click", ".cart-sidebar-close", function (e) {
      e.preventDefault();
      e.stopPropagation();
      closeCartSidebarDropdown();
    });

    $(document).on(
      "click",
      "#cart-sidebar-form [data-sidebar-count-up]",
      function (e) {
        handleCartSidebarQtyButton.call(this, e, true);
      }
    );

    $(document).on(
      "click",
      "#cart-sidebar-form [data-sidebar-count-down]",
      function (e) {
        handleCartSidebarQtyButton.call(this, e, false);
      }
    );

    $(document).on(
      "change",
      "#cart-sidebar-form .form-counter input.quantity, #cart-sidebar-form .choose_quantity input.quantity",
      function () {
        if (cartSidebarQtyLock) {
          return;
        }
        scheduleCartSidebarUpdate();
      }
    );

    $(document).on(
      "click touchend",
      "#cart-sidebar-form .cart-sidebar-delete",
      function (e) {
        var now = Date.now();
        if (now - cartSidebarLastDeleteAt < 500) {
          e.preventDefault();
          e.stopPropagation();
          return;
        }
        cartSidebarLastDeleteAt = now;

        e.preventDefault();
        e.stopPropagation();
        window.clearTimeout(cartSidebarUpdateTimer);
        removeCartSidebarPosition(
          $(this).closest("#cart-sidebar-form"),
          getCartSidebarDeleteIndex($(this))
        );
      }
    );

    $(document).on("submit", "#cart-sidebar-form", function (e) {
      e.preventDefault();
      window.clearTimeout(cartSidebarUpdateTimer);

      var submitter = e.originalEvent && e.originalEvent.submitter;
      if (submitter && submitter.name === "dropPos") {
        removeCartSidebarPosition($(this), submitter.value);
      } else {
        submitCartSidebarForm($(this));
      }
    });

    // Nach Seitenwechsel Sidebar mit Server-Session abgleichen
    syncCartSidebarFromServer();
  });

  $(document).on("evo:contentLoaded", function () {
    markBasketPage();
    if (cartSidebarSkipNextContentLoadedSync) {
      cartSidebarSkipNextContentLoadedSync = false;
      return;
    }
    // Kein Auto-Sync bei offener Sidebar – verhindert DOM-Ersatz-Loop/Blinken
    if (document.body.classList.contains("cart-sidebar-open")) {
      return;
    }
    syncCartSidebarFromServer();
  });

  window.addEventListener("pageshow", function (ev) {
    if (ev.persisted) {
      syncCartSidebarFromServer();
    }
  });

  // Nach Warenkorb-Updates UI neu binden (PayPal nur bei Bedarf in patchCartSidebarBody)
  $(document).ajaxComplete(function (event, xhr, settings) {
    if (!isCartSidebarContext()) {
      return;
    }
    var data = settings && settings.data ? String(settings.data) : "";
    if (data.indexOf("getBasketItems") !== -1 || data.indexOf("pushToBasket") !== -1) {
      window.setTimeout(function () {
        initCartSidebarUi($(".cart-icon-dropdown"));
        if (
          window.__beautekOpenSidebarAfterCart &&
          data.indexOf("getBasketItems") !== -1
        ) {
          revealCartSidebarAfterAdd();
        }
      }, 0);
    }
  });
})(jQuery);

/* Mobile PayPal Express: Redirect-Fallback ohne Plugin-Hook (Desktop unberührt) */
(function () {
  var PPC_ECS_PATH = "/paypal-express-zahlung";

  function isMobileExpressContext() {
    return (
      document.body.classList.contains("is-mobile") &&
      (document.body.getAttribute("data-page") === "1" ||
        document.body.classList.contains("is-basket-page") ||
        document.querySelector(".container.basket"))
    );
  }

  function isPayPalApprovePending() {
    if (document.querySelector('[id*="ppc"].opacity-half')) {
      return true;
    }
    if (document.querySelector('[id*="ppc"] .opacity-half')) {
      return true;
    }

    var spinners = document.querySelectorAll(
      '[id*="ppc-loading-spinner-express"]:not(.d-none):not(.hidden)'
    );
    return spinners.length > 0;
  }

  function maybeCompleteExpressRedirect() {
    if (!isMobileExpressContext()) {
      return;
    }
    if (window.location.pathname.indexOf("paypal-express") !== -1) {
      return;
    }
    if (!isPayPalApprovePending()) {
      return;
    }
    window.location.assign(PPC_ECS_PATH);
  }

  function scheduleRedirectCheck() {
    window.setTimeout(maybeCompleteExpressRedirect, 120);
    window.setTimeout(maybeCompleteExpressRedirect, 600);
  }

  document.addEventListener(
    "click",
    function (e) {
      if (!document.body.classList.contains("is-mobile") || !e.target || !e.target.closest) {
        return;
      }
      if (
        e.target.closest(
          '[id*="ppc-"], [id*="paypal"], .paypal-buttons, .paypal-button, [id*="zoid-paypal"], iframe[src*="paypal"]'
        )
      ) {
        window.__ppcPaymentActive = true;
      }
    },
    true
  );

  document.addEventListener("visibilitychange", function () {
    if (document.visibilityState === "visible") {
      scheduleRedirectCheck();
    }
  });

  window.addEventListener("pageshow", function () {
    scheduleRedirectCheck();
  });
})();

/* Beautek PDP v2 – Variationen als Pill-Buttons (?v=pdp2) */
(function ($) {
  function isPdpV2() {
    return document.body.classList.contains("beautek-pdp-v2");
  }

  function colorDotClass(name) {
    var n = String(name || "").toLowerCase();
    if (n.indexOf("dunkelgrau") !== -1 || n.indexOf("anthrazit") !== -1) return "is-dunkelgrau";
    if (n.indexOf("grau") !== -1 || n.indexOf("gray") !== -1 || n.indexOf("grey") !== -1) return "is-grau";
    if (n.indexOf("schwarz") !== -1 || n.indexOf("black") !== -1) return "is-schwarz";
    if (n.indexOf("weiß") !== -1 || n.indexOf("weiss") !== -1 || n.indexOf("white") !== -1) return "is-white";
    if (n.indexOf("beige") !== -1 || n.indexOf("creme") !== -1) return "is-beige";
    return "";
  }

  function looksLikeColorVariation(labelText) {
    var t = String(labelText || "").toLowerCase();
    return (
      t.indexOf("polster") !== -1 ||
      t.indexOf("farbe") !== -1 ||
      t.indexOf("color") !== -1 ||
      t.indexOf("colour") !== -1
    );
  }

  function splitOptionLabel(raw) {
    var text = String(raw || "").replace(/\s+/g, " ").trim();
    // "mit Memory: … + 300,00 €" → title + meta
    var m = text.match(/^(.*?)(?:\s*:\s*|\s+[–—-]\s+)(.+)$/);
    if (m) {
      return { title: m[1].trim(), meta: m[2].trim() };
    }
    // Preis am Ende
    var p = text.match(/^(.*?)(\+\s*[\d.,]+\s*€.*)$/);
    if (p) {
      return { title: p[1].trim(), meta: p[2].trim() };
    }
    return { title: text, meta: "" };
  }

  function shortColorTitle(title) {
    var t = String(title || "");
    // "Weiß I 4M (…)" → "Weiß"
    var head = t.split(/\s+I\s+|\s+\|\s+/)[0];
    return (head || t).trim();
  }

  function ensureOptionCount($dt, count) {
    if (!$dt.length || count < 1) return;
    var $count = $dt.find(".beautek-pdp-v2-opt-count");
    if (!$count.length) {
      $count = $('<span class="beautek-pdp-v2-opt-count"></span>');
      $dt.append($count);
    }
    $count.text(count + (count === 1 ? " Option" : " Optionen"));
  }

  function buildPillsForSelect($select) {
    if (!$select.length) return;

    var $host = $select.closest("dd, .variation-wrapper, .form-group");
    if (!$host.length) $host = $select.parent();

    // Nach AJAX neu aufbauen (Options/Verfügbarkeit ändern sich)
    $host.find(".beautek-pdp-v2-pills").remove();
    $select.off("change.beautekPdpV2");
    $select.removeData("beautekPills");

    var $dt = $host.closest("dl, .variation-wrapper").find("dt").first();
    if (!$dt.length) $dt = $host.prev("dt");

    var labelText = $dt.clone().children(".beautek-pdp-v2-opt-count, .swatches-selected, .js-btn-slider-btns").remove().end().text();
    var isColor = looksLikeColorVariation(labelText);

    var $pills = $('<div class="beautek-pdp-v2-pills" role="listbox"></div>');
    var optionCount = 0;

    $select.find("option").each(function () {
      var $opt = $(this);
      var val = $opt.attr("value");
      if (val === undefined || val === null || val === "") return;

      optionCount += 1;
      var rawLabel = $opt.attr("data-original") || $opt.text();
      var parts = splitOptionLabel(rawLabel);
      var title = isColor ? shortColorTitle(parts.title) : parts.title;
      var meta = parts.meta;
      var disabled = !!$opt.prop("disabled");
      var selected = !!$opt.prop("selected");
      var dotClass = isColor ? colorDotClass(title + " " + rawLabel) : "";

      var $btn = $('<button type="button" class="beautek-pdp-v2-pill" role="option"></button>');
      $btn.attr("data-value", val);
      if (selected) $btn.addClass("is-active").attr("aria-selected", "true");
      if (disabled) $btn.addClass("is-disabled").prop("disabled", true);

      if (dotClass) {
        $btn.append('<span class="beautek-pdp-v2-pill-dot ' + dotClass + '" aria-hidden="true"></span>');
      }

      var $text = $('<span class="beautek-pdp-v2-pill-text"></span>');
      $text.append($('<span class="beautek-pdp-v2-pill-title"></span>').text(title));
      if (meta) {
        $text.append($('<span class="beautek-pdp-v2-pill-meta"></span>').text(meta));
      }
      $btn.append($text);
      $pills.append($btn);
    });

    if (optionCount < 1) return;

    ensureOptionCount($dt, optionCount);

    $select.addClass("beautek-pdp-v2-select-native");
    try {
      if ($select.data("selectpicker")) {
        $select.selectpicker("hide");
      }
    } catch (e) {}

    var $bs = $select.closest(".bootstrap-select");
    if ($bs.length) {
      $bs.after($pills);
    } else {
      $select.after($pills);
    }

    $pills.on("click", ".beautek-pdp-v2-pill", function () {
      var $btn = $(this);
      if ($btn.hasClass("is-disabled")) return;
      var value = $btn.attr("data-value");
      $pills.find(".beautek-pdp-v2-pill").removeClass("is-active").attr("aria-selected", "false");
      $btn.addClass("is-active").attr("aria-selected", "true");
      $select.val(value).trigger("change");
      try {
        if ($select.data("selectpicker")) {
          $select.selectpicker("val", value);
        }
      } catch (e2) {}
    });

    $select.on("change.beautekPdpV2", function () {
      var current = String($select.val() || "");
      $pills.find(".beautek-pdp-v2-pill").each(function () {
        var on = String($(this).attr("data-value")) === current;
        $(this).toggleClass("is-active", on).attr("aria-selected", on ? "true" : "false");
      });
    });

    $select.data("beautekPills", 1);
  }

  function enhanceRadios($root) {
    $root.find(".custom-radio").each(function () {
      var $group = $(this).parent();
      var $dt = $group.closest(".variation-wrapper, dl").find("dt").first();
      var count = $group.find(".custom-radio").length;
      ensureOptionCount($dt, count);
    });

    $root.find(".custom-radio > label.variation").each(function () {
      var $label = $(this);
      if ($label.find("> .beautek-pdp-v2-pill-text").length) {
        $label.data("beautekRadioPill", 1);
        return;
      }
      if ($label.data("beautekRadioPill") === 1) return;

      var raw = String($label.attr("data-original") || "").replace(/\s+/g, " ").trim();
      if (!raw) {
        raw = String($label.text() || "").replace(/\s+/g, " ").trim();
      }
      var parts = splitOptionLabel(raw);
      var $badge = $label.find(".variation-badge").detach();
      var $keep = $label.children(".badge-not-available").detach();

      $label.empty();

      var $text = $('<span class="beautek-pdp-v2-pill-text"></span>');
      $text.append($('<span class="beautek-pdp-v2-pill-title"></span>').text(parts.title || raw));
      if (parts.meta) {
        $text.append($('<span class="beautek-pdp-v2-pill-meta"></span>').text(parts.meta));
      }
      if ($badge.length) {
        $badge.addClass("beautek-pdp-v2-pill-meta").removeClass("variation-badge badge-right badge-left");
        $text.append($badge);
      }
      $label.append($text);
      if ($keep.length) $label.append($keep);

      $label.data("beautekRadioPill", 1);
    });
  }

  function enhanceSwatches($root) {
    $root.find(".swatches").each(function () {
      var $row = $(this);
      var $dt = $row.closest(".variation-wrapper, dl").find("dt").first();
      var count = $row.find("label.variation").length;
      ensureOptionCount($dt, count);
    });

    // Attributname säubern: nur „Polsterfarbe“, nicht die lange Wertbezeichnung
    $root.find(".variation-wrapper").each(function () {
      var $wrap = $(this);
      var $dt = $wrap.find("dt").first();
      if (!$dt.length || $dt.data("beautekLabelClean") === 1) return;

      var $count = $dt.find(".beautek-pdp-v2-opt-count").detach();
      var $slider = $dt.find(".js-btn-slider-btns").detach();
      $dt.find(".swatches-selected").remove();

      var raw = String($dt.text() || "").replace(/\s+/g, " ").trim();
      // „Polsterfarbe Dunkelgrau …“ → „Polsterfarbe“
      var clean = raw.split(/\s{2,}|\s+(?=[A-ZÄÖÜ])/)[0] || raw;
      if (/polsterfarbe/i.test(raw)) clean = "Polsterfarbe";
      else if (/memory/i.test(raw)) clean = "Memory-Funktion";
      else if (/farbe/i.test(raw)) clean = "Farbe";

      $dt.empty().append(document.createTextNode(clean + " "));
      if ($count.length) $dt.append($count);
      if ($slider.length) $dt.append($slider);
      $dt.data("beautekLabelClean", 1);
    });
  }

  function initPdpV2Variations(context) {
    if (!isPdpV2()) return;
    var $root = $(context || document).find(".beautek-pdp-v2-variations");
    if (!$root.length && $(context).hasClass && $(context).hasClass("beautek-pdp-v2-variations")) {
      $root = $(context);
    }
    if (!$root.length) return;

    $root.find('select[name^="eigenschaftwert"]').each(function () {
      buildPillsForSelect($(this));
    });
    enhanceRadios($root);
    enhanceSwatches($root);
  }

  $(function () {
    initPdpV2Variations(document);
  });

  $(document).ajaxComplete(function () {
    window.setTimeout(function () {
      initPdpV2Variations(document);
    }, 50);
  });

  $(document).on("evo:contentLoaded", function () {
    window.setTimeout(function () {
      initPdpV2Variations(document);
    }, 50);
  });
})(window.jQuery);

/* Beautek – Kartentitel Variante B (live auf Kategorie/Liste) */
(function () {
  var BRANDS = [
    "BEAUTEK",
    "Beautek",
    "Naggura",
    "Silverfox",
    "SILVERFOX",
    "Weelko",
    "Dirks",
  ];

  function stripBrand(text) {
    var t = String(text || "").replace(/\s+/g, " ").trim();
    for (var i = 0; i < BRANDS.length; i++) {
      var re = new RegExp("^" + BRANDS[i].replace(/[.*+?^${}()|[\]\\]/g, "\\$&") + "\\s+", "i");
      t = t.replace(re, "");
    }
    return t.trim();
  }

  function shortenTitle(title) {
    var t = stripBrand(title);
    t = t.replace(/^Elektrische\s+Kosmetikliege\s+/i, "Elektrische ");

    var m = t.match(/^Kosmetikliege\s+(.+)$/i);
    if (m) {
      var rest = m[1].trim();
      // Numerische Modelle: „Kosmetikliege 331 …“ behalten
      if (/^\d/.test(rest)) return t;
      // Kurzer Eigenname wie Wolke: Präfix behalten
      if (/^Wolke\b/i.test(rest) && rest.split(/\s+/).length <= 2) return t;
      // Benannte Linien: nur den Namen (Start Up, Sandy Neutral, Swop …)
      return rest;
    }
    return t;
  }

  function compactPart(part) {
    var p = String(part || "").trim();
    p = p.replace(/^Wahlweise\s+mit\s+/i, "");
    p = p.replace(/^optional(?:e|er|es)?\s+/i, "");
    p = p.replace(/\s+&\s+/g, " · ");
    p = p.replace(/Resetfunktion/gi, "Reset");
    p = p.replace(/Memory-?Funktion/gi, "Memory");
    p = p.replace(/LED-Beleuchtung/gi, "LED");
    p = p.replace(/Trendelenburg-Position/gi, "Trendelenburg");
    p = p.replace(/Verschiedene\s+Polstervarianten/gi, "Polster-Varianten");
    p = p.replace(/Die\s+perfekte\s+Einsteigerliege/gi, "Einsteiger");
    p = p.replace(/Ideal\s+für\s+SPA\s+und\s+Beauty/gi, "SPA & Beauty");
    p = p.replace(/Elegantes\s+Design/gi, "");
    p = p.replace(/mit\s+Heizung/gi, "Heizung");
    p = p.replace(/\s+/g, " ").trim();
    return p;
  }

  function splitName(full) {
    var raw = stripBrand(full);
    var chunks = raw
      .split(/\s+I\s+|\s+\|\s+/)
      .map(function (s) {
        return s.trim();
      })
      .filter(Boolean);

    var title = shortenTitle(chunks[0] || raw);
    var specs = chunks
      .slice(1)
      .map(compactPart)
      .filter(Boolean)
      .slice(0, 3);

    return {
      title: title,
      subtitle: specs.join(" · "),
    };
  }

  function enhanceCardTitles(root) {
    var scope = root && root.querySelectorAll ? root : document;
    var links = scope.querySelectorAll(".js-beautek-card-title a");
    Array.prototype.forEach.call(links, function (a) {
      if (a.getAttribute("data-beautek-title-done") === "1") return;
      var full = a.getAttribute("data-full-name") || a.textContent || "";
      full = full.replace(/\s+/g, " ").trim();
      if (!full) return;

      var parts = splitName(full);
      a.textContent = parts.title;
      a.setAttribute("title", full);
      a.setAttribute("data-beautek-title-done", "1");

      var wrap = a.closest(".productbox-title");
      if (!wrap) return;

      var next = wrap.nextElementSibling;
      var sub =
        next && next.classList.contains("beautek-productbox-subtitle")
          ? next
          : null;
      if (!sub) {
        sub = document.createElement("div");
        sub.className = "beautek-productbox-subtitle";
        wrap.insertAdjacentElement("afterend", sub);
      }
      if (parts.subtitle) {
        sub.textContent = parts.subtitle;
        sub.style.display = "";
      } else {
        sub.textContent = "";
        sub.style.display = "none";
      }
      wrap.classList.add("beautek-productbox-title");
    });
  }

  function colorDotClass(name) {
    var n = String(name || "").toLowerCase();
    if (n.indexOf("dunkelgrau") !== -1 || n.indexOf("anthrazit") !== -1) return "is-dunkelgrau";
    if (n.indexOf("grau") !== -1 || n.indexOf("gray") !== -1 || n.indexOf("grey") !== -1) return "is-grau";
    if (n.indexOf("schwarz") !== -1 || n.indexOf("black") !== -1) return "is-schwarz";
    if (n.indexOf("weiß") !== -1 || n.indexOf("weiss") !== -1 || n.indexOf("white") !== -1) return "is-white";
    if (n.indexOf("beige") !== -1 || n.indexOf("creme") !== -1 || n.indexOf("sand") !== -1 || n.indexOf("taupe") !== -1) return "is-beige";
    if (n.indexOf("braun") !== -1) return "is-beige";
    if (n.indexOf("blau") !== -1 || n.indexOf("navy") !== -1 || n.indexOf("türkis") !== -1 || n.indexOf("tuerkis") !== -1) return "is-blau";
    if (n.indexOf("rot") !== -1 || n.indexOf("pink") !== -1 || n.indexOf("bordeaux") !== -1) return "is-rot";
    if (n.indexOf("grün") !== -1 || n.indexOf("gruen") !== -1 || n.indexOf("olive") !== -1) return "is-gruen";
    if (n.indexOf("lila") !== -1 || n.indexOf("violett") !== -1 || n.indexOf("purple") !== -1) return "is-lila";
    if (n.indexOf("gelb") !== -1 || n.indexOf("orange") !== -1 || n.indexOf("senf") !== -1) return "is-gelb";
    return "";
  }

  function enhanceSwatchDots(root) {
    var scope = root && root.querySelectorAll ? root : document;
    var rows = scope.querySelectorAll(".beautek-productbox-swatches");
    Array.prototype.forEach.call(rows, function (row) {
      var dots = row.querySelectorAll(".beautek-productbox-swatch");
      var usable = 0;
      Array.prototype.forEach.call(dots, function (dot) {
        if (dot.getAttribute("data-beautek-swatch-done") === "1") {
          if (dot.style.display !== "none" && (dot.classList.contains("has-image") || /(?:^|\s)is-/.test(dot.className))) {
            usable += 1;
          }
          return;
        }
        var img = dot.querySelector("img");
        if (img && img.getAttribute("src")) {
          dot.classList.add("has-image");
          usable += 1;
          dot.setAttribute("data-beautek-swatch-done", "1");
          return;
        }
        var cls = colorDotClass(dot.getAttribute("data-color-name"));
        if (cls) {
          dot.classList.add(cls);
          usable += 1;
        } else {
          dot.style.display = "none";
        }
        dot.setAttribute("data-beautek-swatch-done", "1");
      });
      if (usable < 2) {
        row.style.display = "none";
      }
    });
  }

  function run() {
    enhanceCardTitles(document);
    enhanceSwatchDots(document);
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", run);
  } else {
    run();
  }

  if (window.jQuery) {
    window.jQuery(document).ajaxComplete(function () {
      window.setTimeout(run, 50);
    });
    window.jQuery(document).on("evo:contentLoaded", function () {
      window.setTimeout(run, 50);
    });
  }
})();

/* Beautek Konfigurator → kompakte Buybox-UX (?v=cfg) */
(function ($) {
  function isCfgPills() {
    return document.body.classList.contains("beautek-cfg-pills");
  }

  function colorDotClass(name) {
    var n = String(name || "").toLowerCase();
    if (n.indexOf("beton") !== -1 && n.indexOf("hell") !== -1) return "is-beton-hell";
    if (n.indexOf("beton") !== -1 && n.indexOf("dunkel") !== -1) return "is-beton-dunkel";
    if (n.indexOf("dunkelgrau") !== -1 || n.indexOf("anthrazit") !== -1) return "is-dunkelgrau";
    if (n.indexOf("grau") !== -1 || n.indexOf("gray") !== -1 || n.indexOf("grey") !== -1) return "is-grau";
    if (n.indexOf("schwarz") !== -1 || n.indexOf("black") !== -1) return "is-schwarz";
    if (n.indexOf("weiß") !== -1 || n.indexOf("weiss") !== -1 || n.indexOf("white") !== -1) return "is-white";
    if (n.indexOf("beige") !== -1 || n.indexOf("creme") !== -1) return "is-beige";
    if (n.indexOf("bordeaux") !== -1 || n.indexOf("weinrot") !== -1) return "is-bordeaux";
    if (n.indexOf("taupe") !== -1) return "is-taupe";
    if (n.indexOf("eiche") !== -1 || n.indexOf("holz") !== -1) return "is-eiche";
    return "";
  }

  function groupMode(label) {
    var t = String(label || "").toLowerCase();
    if (
      t.indexOf("fuß") !== -1 ||
      t.indexOf("fuss") !== -1 ||
      t.indexOf("gestell") !== -1 ||
      t.indexOf("sockel") !== -1 ||
      t.indexOf("bein") !== -1 ||
      t.indexOf("untergestell") !== -1
    ) {
      return "image";
    }
    if (
      t.indexOf("polster") !== -1 ||
      t.indexOf("farbe") !== -1 ||
      t.indexOf("korpus") !== -1 ||
      t.indexOf("color") !== -1 ||
      t.indexOf("colour") !== -1
    ) {
      return "color";
    }
    return "pill";
  }

  function splitLabel(raw) {
    var text = String(raw || "")
      .replace(/Artikeldetails/gi, " ")
      .replace(/\s+/g, " ")
      .trim();
    var p = text.match(/^(.*?)(\+\s*[\d.,]+\s*€.*)$/);
    if (p) return { title: p[1].trim(), meta: p[2].trim() };
    var z = text.match(/^(.*?)([\d.,]+\s*€.*)$/);
    if (z && z[1].length > 2) return { title: z[1].trim(), meta: z[2].trim() };
    return { title: text, meta: "" };
  }

  function cleanMeta(meta) {
    var m = String(meta || "").replace(/\s+/g, " ").trim();
    if (!m) return "";
    if (/artikeldetails/i.test(m)) return "";
    if (/^0[,.]00\s*€/.test(m)) return "";
    if (/im preis/i.test(m)) return "";
    return m;
  }

  function extractItemLabel($item) {
    var $desc = $item.find(".cfg-item-description");
    var title = "";
    var meta = "";
    var $dt = $desc.find("dt").first();
    if ($dt.length) {
      var $dtClone = $dt.clone();
      var priceFromBadge = String($dtClone.find(".badge").first().text() || "").replace(/\s+/g, " ").trim();
      $dtClone.find(".badge, a, button, .cfg-item-detail-button").remove();
      title = String($dtClone.text() || "").replace(/\s+/g, " ").trim();
      meta = cleanMeta(priceFromBadge);
    }
    if (!title) {
      var $clone = $desc.clone();
      $clone.find(".cfg-item-detail-button, .cfg-item-qty, .badge, a, img, dd, .price-note").remove();
      title = String($clone.text() || "").replace(/\s+/g, " ").trim();
    }
    if (!title) title = String($item.find("img").attr("alt") || "").trim();
    title = title
      .replace(/\s*-\s*nicht\s*auf\s*lager.*/i, "")
      .replace(/Artikeldetails/gi, "")
      .replace(/\s+/g, " ")
      .trim();
    return { title: title, meta: meta };
  }

  function itemImageSrc($item) {
    var $img = $item.find("img").filter(function () {
      var src = $(this).attr("src") || $(this).attr("data-src") || "";
      return src && src.indexOf("kein") === -1 && src.indexOf("platzhalter") === -1;
    }).first();
    if (!$img.length) $img = $item.find("img").first();
    return $img.attr("src") || $img.attr("data-src") || $img.attr("data-srcset") || "";
  }

  function groupLabel($group) {
    var $btn = $group.find(".hr-sect button, .hr-sect .btn").first();
    if ($btn.length) return String($btn.text() || "").replace(/\s+/g, " ").trim();
    return String($group.find(".hr-sect").first().clone().children().remove().end().text() || "")
      .replace(/\s+/g, " ")
      .trim();
  }

  function resolveInput($btn, $inputs) {
    var id = $btn.attr("data-input-id");
    var $input = $();
    if (id) {
      try {
        $input = $(document.getElementById(id));
      } catch (e) {
        $input = $();
      }
    }
    if (!$input.length) {
      var val = $btn.attr("data-value");
      $input = $inputs.filter(function () {
        return String($(this).val()) === String(val);
      }).first();
    }
    return $input;
  }

  function syncChoiceState($row, $inputs) {
    $row.find("[data-value]").each(function () {
      var $btn = $(this);
      var $input = resolveInput($btn, $inputs);
      var on = $input.length && ($input.is("select") ? String($input.val()) === String($btn.attr("data-value")) : $input.prop("checked"));
      $btn.toggleClass("is-active", !!on).attr("aria-selected", on ? "true" : "false");
    });
  }

  function selectInput($input, $inputs) {
    if (!$input.length || $input.prop("disabled")) return;
    if ($input.is("select")) {
      $input.val($input.val()).trigger("change");
      return;
    }
    if ($input.attr("type") === "checkbox") {
      $input.trigger("click");
      return;
    }
    if (!$input.prop("checked")) {
      $input.prop("checked", true).trigger("click").trigger("change");
    } else {
      $input.trigger("change");
    }
  }

  function buildGroupUI($group, $mount) {
    var $inputs = $group.find('input.cfg-swatch[type="radio"], input.cfg-swatch[type="checkbox"]');
    var $select = $group.find('select[name^="item["]').first();
    var useSelect = !$inputs.length && $select.length;
    if (!$inputs.length && !useSelect) return;

    var label = groupLabel($group);
    var mode = groupMode(label);
    var $block = $('<div class="beautek-cfg-buybox-group"></div>');
    $block.attr("data-mode", mode);
    var $head = $('<div class="beautek-cfg-buybox-head"></div>');
    $head.append($('<span class="beautek-cfg-buybox-label"></span>').text(label));
    var $selected = $('<span class="beautek-cfg-buybox-selected"></span>');
    $head.append($selected);
    $block.append($head);

    var $row = $('<div class="beautek-cfg-buybox-options" role="listbox"></div>');
    $row.attr("data-mode", mode);
    var activeLabel = "";

    function bindChoice($btn, getLabel) {
      $btn.on("click", function () {
        if ($btn.hasClass("is-disabled")) return;
        if (useSelect) {
          $select.val($btn.attr("data-value")).trigger("change");
        } else {
          selectInput(resolveInput($btn, $inputs), $inputs);
        }
        $selected.html('Gewählt: <em></em>').find("em").text(getLabel());
        syncChoiceState($row, useSelect ? $select : $inputs);
      });
    }

    if (useSelect) {
      $select.find("option").each(function () {
        var $opt = $(this);
        var val = $opt.attr("value");
        if (val === undefined || val === null || val === "") return;
        var parts = splitLabel($opt.text());
        var title = parts.title;
        var meta = cleanMeta(parts.meta);
        var disabled = !!$opt.prop("disabled");
        var selected = !!$opt.prop("selected");
        if (selected) activeLabel = title;

        var $btn;
        if (mode === "color") {
          $btn = $('<button type="button" class="beautek-cfg-swatch" role="option"></button>');
          var dot = colorDotClass(title);
          $btn.append($('<span class="beautek-cfg-swatch-fill ' + (dot || "is-fallback") + '"></span>'));
          $btn.attr("title", title + (meta ? " · " + meta : ""));
          $btn.append($('<span class="beautek-cfg-swatch-name"></span>').text(title));
        } else if (mode === "image") {
          $btn = $('<button type="button" class="beautek-cfg-tile" role="option"></button>');
          $btn.append($('<span class="beautek-cfg-tile-ph" aria-hidden="true"></span>').text(title.charAt(0) || "?"));
          $btn.append($('<span class="beautek-cfg-tile-name"></span>').text(title));
        } else {
          $btn = $('<button type="button" class="beautek-cfg-pill" role="option"></button>');
          var $text = $('<span class="beautek-cfg-pill-text"></span>');
          $text.append($('<span class="beautek-cfg-pill-title"></span>').text(title));
          if (meta) $text.append($('<span class="beautek-cfg-pill-meta"></span>').text(meta));
          $btn.append($text);
        }

        $btn.attr("data-value", val);
        if (selected) $btn.addClass("is-active").attr("aria-selected", "true");
        if (disabled) $btn.addClass("is-disabled").prop("disabled", true);
        bindChoice($btn, function () { return title; });
        $row.append($btn);
      });
      $select.addClass("beautek-cfg-native-hidden");
      $select.off("change.beautekCfgBuybox").on("change.beautekCfgBuybox", function () {
        syncChoiceState($row, $select);
      });
    } else {
      $inputs.each(function () {
        var $input = $(this);
        var $item = $input.closest(".custom-control, .form-check, [class*='col']").find(".config-item").first();
        if (!$item.length) $item = $input.siblings("label").find(".config-item").first();

        var extracted = extractItemLabel($item);
        var parts = splitLabel(extracted.title);
        var title = parts.title || extracted.title || String($input.attr("id") || "");
        var meta = cleanMeta(parts.meta || extracted.meta);
        var img = itemImageSrc($item);
        var disabled = !!$input.prop("disabled") || $item.hasClass("disabled");
        var selected = !!$input.prop("checked");
        if (selected) activeLabel = title;

        var $btn;
        if (mode === "color") {
          $btn = $('<button type="button" class="beautek-cfg-swatch" role="option"></button>');
          var $fill = $('<span class="beautek-cfg-swatch-fill" aria-hidden="true"></span>');
          var dot = colorDotClass(title);
          if (img) {
            $fill.addClass("has-image").css("background-image", "url('" + img.replace(/'/g, "%27") + "')");
          } else if (dot) {
            $fill.addClass(dot);
          } else {
            $fill.addClass("is-fallback");
          }
          $btn.append($fill);
          $btn.attr("title", title + (meta ? " · " + meta : ""));
          $btn.append($('<span class="beautek-cfg-swatch-name"></span>').text(title));
        } else if (mode === "image") {
          $btn = $('<button type="button" class="beautek-cfg-tile" role="option"></button>');
          if (img) {
            $btn.append($('<img class="beautek-cfg-tile-img" alt="" />').attr("src", img));
          } else {
            $btn.append($('<span class="beautek-cfg-tile-ph" aria-hidden="true"></span>').text(title.charAt(0) || "?"));
          }
          $btn.append($('<span class="beautek-cfg-tile-name"></span>').text(title));
          if (meta) $btn.append($('<span class="beautek-cfg-tile-meta"></span>').text(meta));
        } else {
          $btn = $('<button type="button" class="beautek-cfg-pill" role="option"></button>');
          if (img && mode === "pill") {
            // Optionen mit Bild: kompaktes Thumb + Text
            $btn.addClass("has-thumb");
            $btn.append($('<img class="beautek-cfg-pill-thumb" alt="" />').attr("src", img));
          }
          var $text = $('<span class="beautek-cfg-pill-text"></span>');
          $text.append($('<span class="beautek-cfg-pill-title"></span>').text(title));
          if (meta) $text.append($('<span class="beautek-cfg-pill-meta"></span>').text(meta));
          $btn.append($text);
        }

        $btn.attr("data-input-id", $input.attr("id") || "");
        $btn.attr("data-value", $input.val());
        if (selected) $btn.addClass("is-active").attr("aria-selected", "true");
        if (disabled) $btn.addClass("is-disabled").prop("disabled", true);
        bindChoice($btn, function () { return title; });
        $row.append($btn);
      });

      $group.find(".form-group").addClass("beautek-cfg-native-hidden");
      $group.find(".custom-control, .custom-radio, .custom-checkbox").closest("[class*='col']").addClass("beautek-cfg-native-hidden");
      $inputs.off("change.beautekCfgBuybox").on("change.beautekCfgBuybox", function () {
        syncChoiceState($row, $inputs);
        var $on = $inputs.filter(":checked").first();
        if ($on.length) {
          var $active = $row.find('[data-value="' + $on.val() + '"]').first();
          var txt = $active.find(".beautek-cfg-swatch-name, .beautek-cfg-tile-name, .beautek-cfg-pill-title").first().text();
          $selected.html('Gewählt: <em></em>').find("em").text(txt || "");
        }
      });
    }

    if (activeLabel) $selected.html('Gewählt: <em></em>').find("em").text(activeLabel);
    $block.append($row);
    $mount.append($block);

    $group.addClass("beautek-cfg-group-enhanced beautek-cfg-hint-hidden");
    $group.find(".cfg-group-info").addClass("beautek-cfg-hint-hidden");
  }

  function initCfgPills() {
    if (!isCfgPills()) return;

    var $buybox = $("#beautek-cfg-buybox");
    var $root = $("#product-configurator, #cfg-container, #cfg-accordion");
    if (!$root.length) return;

    var $groups = $root.find(".cfg-group, .js-cfg-group");
    if (!$groups.length) return;

    document.body.classList.add("beautek-cfg-buybox-ready");

    if ($buybox.length) {
      $buybox.empty();
      $groups.each(function () {
        buildGroupUI($(this), $buybox);
      });
    } else {
      // Fallback: weiterhin in der Gruppe rendern
      $groups.each(function () {
        var $g = $(this);
        var $local = $g.find(".beautek-cfg-buybox-fallback");
        if (!$local.length) {
          $local = $('<div class="beautek-cfg-buybox-fallback"></div>');
          $g.prepend($local);
        }
        $local.empty();
        buildGroupUI($g, $local);
      });
    }
  }

  $(function () {
    // Konfigurator oft unterhalb – kurz verzögert + Retry
    initCfgPills();
    window.setTimeout(initCfgPills, 120);
    window.setTimeout(initCfgPills, 400);
  });

  $(document).ajaxComplete(function () {
    window.setTimeout(initCfgPills, 100);
  });

  $(document).on("evo:contentLoaded", function () {
    window.setTimeout(initCfgPills, 100);
  });
})(window.jQuery);

/* Relative Produktlinks unter /search/ auf Shop-Root umbiegen */
(function () {
  function fixSearchRelativeProductLinks(root) {
    var scope = root || document;
    var links = scope.querySelectorAll(
      ".productbox a[href], #result-wrapper a[href], .search-wrapper ~ * a[href], #content a.productbox-image, .productbox-title a[href]"
    );
    if (!links.length) {
      links = scope.querySelectorAll("a[href]");
    }
    for (var i = 0; i < links.length; i++) {
      var a = links[i];
      var href = a.getAttribute("href");
      if (!href || href.charAt(0) === "#" || href.charAt(0) === "?" || href.indexOf("javascript:") === 0) continue;
      if (href.indexOf("http://") === 0 || href.indexOf("https://") === 0 || href.indexOf("//") === 0) continue;

      // /search/Artikel-Slug → /Artikel-Slug
      if (href.indexOf("/search/") === 0) {
        var rest = href.substring("/search/".length);
        if (rest && rest.charAt(0) !== "?") {
          a.setAttribute("href", "/" + rest.replace(/^\//, ""));
        }
        continue;
      }

      // relativer Slug ohne führenden Slash → /Slug
      if (href.charAt(0) !== "/" && href.indexOf("mailto:") !== 0 && href.indexOf("tel:") !== 0) {
        if (a.closest && (a.closest(".productbox") || a.closest("#result-wrapper"))) {
          a.setAttribute("href", "/" + href.replace(/^\.\//, ""));
        }
      }
    }
  }

  function run() {
    fixSearchRelativeProductLinks(document);
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", run);
  } else {
    run();
  }

  if (window.jQuery) {
    window.jQuery(document).ajaxComplete(function () {
      window.setTimeout(run, 30);
    });
    window.jQuery(document).on("evo:contentLoaded", function () {
      window.setTimeout(run, 30);
    });
  }
})();

