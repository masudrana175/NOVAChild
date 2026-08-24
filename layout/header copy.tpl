{block name='layout-header'}
{block name='layout-header-doctype'}<!DOCTYPE html>{/block}
<html {block name='layout-header-html-attributes'}lang="{$meta_language}" itemscope {if $nSeitenTyp === $smarty.const.URLART_ARTIKEL}itemtype="https://schema.org/ItemPage"
      {elseif $nSeitenTyp === $smarty.const.URLART_KATEGORIE}itemtype="https://schema.org/CollectionPage"
      {else}itemtype="https://schema.org/WebPage"{/if}{/block}>
{block name='layout-header-head'}
    <head>
        {block name='layout-header-head-meta'}
            <meta http-equiv="content-type" content="text/html; charset={$smarty.const.JTL_CHARSET}">
            <meta name="description" itemprop="description" content={block name='layout-header-head-meta-description'}"{$meta_description|truncate:1000:"":true}{/block}">
            {if !empty($meta_keywords)}
                <meta name="keywords" itemprop="keywords" content="{block name='layout-header-head-meta-keywords'}{$meta_keywords|truncate:255:'':true}{/block}">
            {/if}
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            {$noindex = $bNoIndex === true  || (isset($Link) && $Link->getNoFollow() === true)}
            <meta name="robots" content="{if $robotsContent}{$robotsContent}{elseif $noindex}noindex{else}index, follow{/if}">

            <meta itemprop="url" content="{$cCanonicalURL}"/>
            {block name='layout-header-head-theme-color'}
                <meta name="theme-color" content="{if $Einstellungen.template.theme.theme_default === 'clear'}#f8bf00{else}#1C1D2C{/if}">
            {/block}
            <meta property="og:type" content="website" />
            <meta property="og:site_name" content="{$meta_title}" />
            <meta property="og:title" content="{$meta_title}" />
            <meta property="og:description" content="{$meta_description|truncate:1000:"":true}" />
            <meta property="og:url" content="{$cCanonicalURL}"/>

            {if $nSeitenTyp === $smarty.const.PAGE_ARTIKEL && !empty($Artikel->Bilder)}
                <meta itemprop="image" content="{$Artikel->Bilder[0]->cURLGross}" />
                <meta property="og:image" content="{$Artikel->Bilder[0]->cURLGross}">
            {elseif $nSeitenTyp === $smarty.const.PAGE_NEWSDETAIL && !empty($newsItem->getPreviewImage())}
                <meta itemprop="image" content="{$imageBaseURL}{$newsItem->getPreviewImage()}" />
                <meta property="og:image" content="{$imageBaseURL}{$newsItem->getPreviewImage()}" />
            {else}
                <meta itemprop="image" content="{$ShopLogoURL}" />
                <meta property="og:image" content="{$ShopLogoURL}" />
            {/if}
        {/block}

        <title itemprop="name">{block name='layout-header-head-title'}{$meta_title}{/block}</title>

        {if !empty($cCanonicalURL) && !$noindex}
            <link rel="canonical" href="{$cCanonicalURL}">
        {/if}

        {block name='layout-header-head-base'}{/block}

        {block name='layout-header-head-icons'}
            <link type="image/x-icon" href="{$shopFaviconURL}" rel="icon">
        {/block}

        {block name='layout-header-head-resources'}
            {if empty($parentTemplateDir)}
                {$templateDir = $currentTemplateDir}
            {else}
                {$templateDir = $parentTemplateDir}
            {/if}
            <style id="criticalCSS">
                {block name='layout-header-head-resources-crit'}
                {file_get_contents("{$currentThemeDir}{$Einstellungen.template.theme.theme_default}_crit.css")}
                {/block}
            </style>
            {* css *}
        {if $Einstellungen.template.general.use_minify === 'N'}
        {foreach $cCSS_arr as $cCSS}
        <link rel="preload" href="{$ShopURL}/{$cCSS}?v={$nTemplateVersion}" as="style"
              onload="this.onload=null;this.rel='stylesheet'">
        {/foreach}
        {if isset($cPluginCss_arr)}
        {foreach $cPluginCss_arr as $cCSS}
        <link rel="preload" href="{$ShopURL}/{$cCSS}?v={$nTemplateVersion}" as="style"
              onload="this.onload=null;this.rel='stylesheet'">
        {/foreach}
        {/if}

            <noscript>
                {foreach $cCSS_arr as $cCSS}
                    <link rel="stylesheet" href="{$ShopURL}/{$cCSS}?v={$nTemplateVersion}">
                {/foreach}
                {if isset($cPluginCss_arr)}
                    {foreach $cPluginCss_arr as $cCSS}
                        <link href="{$ShopURL}/{$cCSS}?v={$nTemplateVersion}" rel="stylesheet">
                    {/foreach}
                {/if}
            </noscript>
            {else}
        <link rel="preload" href="{$ShopURL}/{$combinedCSS}" as="style" onload="this.onload=null;this.rel='stylesheet'">
            <noscript>
                <link href="{$ShopURL}/{$combinedCSS}" rel="stylesheet">
            </noscript>
        {/if}

        {if !$isMobile && !$opc->isEditMode() && !$opc->isPreviewMode() && \JTL\Shop::isAdmin(true)}
        <link rel="preload" href="{$ShopURL}/admin/opc/css/startmenu.css" as="style"
              onload="this.onload=null;this.rel='stylesheet'">
            <noscript>
                <link type="text/css" href="{$ShopURL}/admin/opc/css/startmenu.css" rel="stylesheet">
            </noscript>
        {/if}
        {foreach $opcPageService->getCurPage()->getCssList($opc->isEditMode()) as $cssFile => $cssTrue}
        <link rel="preload" href="{$cssFile}" as="style" data-opc-portlet-css-link="true"
              onload="this.onload=null;this.rel='stylesheet'">
            <noscript>
                <link rel="stylesheet" href="{$cssFile}">
            </noscript>
        {/foreach}
            <script>
              /*! loadCSS rel=preload polyfill. [c]2017 Filament Group, Inc. MIT License */
              (function (w) {
                "use strict";
                if (!w.loadCSS) {
                  w.loadCSS = function (){};
                }
                var rp = loadCSS.relpreload = {};
                rp.support                  = (function () {
                  var ret;
                  try {
                    ret = w.document.createElement("link").relList.supports("preload");
                  } catch (e) {
                    ret = false;
                  }
                  return function () {
                    return ret;
                  };
                })();
                rp.bindMediaToggle          = function (link) {
                  var finalMedia = link.media || "all";

                  function enableStylesheet() {
                    if (link.addEventListener) {
                      link.removeEventListener("load", enableStylesheet);
                    } else if (link.attachEvent) {
                      link.detachEvent("onload", enableStylesheet);
                    }
                    link.setAttribute("onload", null);
                    link.media = finalMedia;
                  }

                  if (link.addEventListener) {
                    link.addEventListener("load", enableStylesheet);
                  } else if (link.attachEvent) {
                    link.attachEvent("onload", enableStylesheet);
                  }
                  setTimeout(function () {
                    link.rel   = "stylesheet";
                    link.media = "only x";
                  });
                  setTimeout(enableStylesheet, 3000);
                };

                rp.poly = function () {
                  if (rp.support()) {
                    return;
                  }
                  var links = w.document.getElementsByTagName("link");
                  for (var i = 0; i < links.length; i++) {
                    var link = links[i];
                    if (link.rel === "preload" && link.getAttribute("as") === "style" && !link.getAttribute("data-loadcss")) {
                      link.setAttribute("data-loadcss", true);
                      rp.bindMediaToggle(link);
                    }
                  }
                };

                if (!rp.support()) {
                  rp.poly();

                  var run = w.setInterval(rp.poly, 500);
                  if (w.addEventListener) {
                    w.addEventListener("load", function () {
                      rp.poly();
                      w.clearInterval(run);
                    });
                  } else if (w.attachEvent) {
                    w.attachEvent("onload", function () {
                      rp.poly();
                      w.clearInterval(run);
                    });
                  }
                }

                if (typeof exports !== "undefined") {
                  exports.loadCSS = loadCSS;
                }
                else {
                  w.loadCSS = loadCSS;
                }
              }(typeof global !== "undefined" ? global : this));
            </script>
            {* RSS *}
        {if isset($Einstellungen.rss.rss_nutzen) && $Einstellungen.rss.rss_nutzen === 'Y'}
        <link rel="alternate" type="application/rss+xml" title="Newsfeed {$Einstellungen.global.global_shopname}"
              href="{$ShopURL}/rss.xml">
        {/if}
            {* Languages *}
        {if !empty($smarty.session.Sprachen) && count($smarty.session.Sprachen) > 1}
        {foreach $smarty.session.Sprachen as $language}
        <link rel="alternate"
              hreflang="{$language->getIso639()}"
              href="{if $language->getShopDefault() === 'Y' && isset($Link) && $Link->getLinkType() === $smarty.const.LINKTYP_STARTSEITE}{$ShopURL}/{else}{$language->getUrl()}{/if}">
        {/foreach}
        {/if}
        {/block}

        {if isset($Suchergebnisse) && $Suchergebnisse->getPages()->getMaxPage() > 1}
            {block name='layout-header-prev-next'}
                {if $Suchergebnisse->getPages()->getCurrentPage() > 1}
                    <link rel="prev" href="{$filterPagination->getPrev()->getURL()}">
                {/if}
                {if $Suchergebnisse->getPages()->getCurrentPage() < $Suchergebnisse->getPages()->getMaxPage()}
                    <link rel="next" href="{$filterPagination->getNext()->getURL()}">
                {/if}
            {/block}
        {/if}
        {$dbgBarHead}

        <script>
          window.lazySizesConfig = window.lazySizesConfig || {};
          window.lazySizesConfig.expand  = 50;
        </script>
        <script src="{$ShopURL}/{$templateDir}js/jquery-3.5.1.min.js"></script>
        <script src="{$ShopURL}/{$templateDir}js/lazysizes.min.js"></script>

        {if $Einstellungen.template.general.use_minify === 'N'}
        {if isset($cPluginJsHead_arr)}
        {foreach $cPluginJsHead_arr as $cJS}
            <script defer src="{$ShopURL}/{$cJS}?v={$nTemplateVersion}"></script>
        {/foreach}
        {/if}
        {foreach $cJS_arr as $cJS}
            <script defer src="{$ShopURL}/{$cJS}?v={$nTemplateVersion}"></script>
        {/foreach}
        {foreach $cPluginJsBody_arr as $cJS}
            <script defer src="{$ShopURL}/{$cJS}?v={$nTemplateVersion}"></script>
        {/foreach}
        {else}
        {foreach $minifiedJS as $item}
            <script defer src="{$ShopURL}/{$item}"></script>
        {/foreach}
        {/if}

        {if file_exists($currentTemplateDirFullPath|cat:'js/custom.js')}
            <script defer src="{$ShopURL}/{$currentTemplateDir}js/custom.js?v={$nTemplateVersion}"></script>
        {/if}

        {getUploaderLang iso=$smarty.session.currentLanguage->getIso639()|default:'' assign='uploaderLang'}

        {block name='layout-header-head-resources-preload'}
            <link rel="preload" href="{$ShopURL}/{$currentTemplateDir}themes/base/fonts/poppins/poppins-v20-latin-300.woff" as="font" crossorigin/>
            <link rel="preload" href="{$ShopURL}/{$currentTemplateDir}themes/base/fonts/poppins/poppins-v20-latin-300.woff2" as="font" crossorigin/>
            <link rel="preload" href="{$ShopURL}/{$currentTemplateDir}themes/base/fonts/poppins/poppins-v20-latin-600.woff" as="font" crossorigin/>
            <link rel="preload" href="{$ShopURL}/{$currentTemplateDir}themes/base/fonts/poppins/poppins-v20-latin-600.woff2" as="font" crossorigin/>
            <link rel="preload" href="{$ShopURL}/{$currentTemplateDir}themes/base/fonts/poppins/poppins-v20-latin-regular.woff" as="font" crossorigin/>
            <link rel="preload" href="{$ShopURL}/{$currentTemplateDir}themes/base/fonts/poppins/poppins-v20-latin-regular.woff2" as="font" crossorigin/>

            <link rel="preload" href="{$ShopURL}/{$currentTemplateDir}themes/base/fonts/raleway/raleway-v28-latin-regular.woff" as="font" crossorigin/>
            <link rel="preload" href="{$ShopURL}/{$currentTemplateDir}themes/base/fonts/raleway/raleway-v28-latin-regular.woff2" as="font" crossorigin/>
            <link rel="preload" href="{$ShopURL}/{$currentTemplateDir}themes/base/fonts/raleway/raleway-v28-latin-600.woff" as="font" crossorigin/>
            <link rel="preload" href="{$ShopURL}/{$currentTemplateDir}themes/base/fonts/raleway/raleway-v28-latin-600.woff2" as="font" crossorigin/>
            <link rel="preload" href="{$ShopURL}/{$currentTemplateDir}themes/base/fonts/raleway/raleway-v28-latin-700.woff" as="font" crossorigin/>
            <link rel="preload" href="{$ShopURL}/{$currentTemplateDir}themes/base/fonts/raleway/raleway-v28-latin-700.woff2" as="font" crossorigin/>

            <link rel="preload" href="{$ShopURL}/{$templateDir}themes/base/fontawesome/webfonts/fa-solid-900.woff2" as="font" crossorigin/>
            <link rel="preload" href="{$ShopURL}/{$templateDir}themes/base/fontawesome/webfonts/fa-regular-400.woff2" as="font" crossorigin/>
        {/block}
        {block name='layout-header-head-resources-modulepreload'}
            <link rel="modulepreload" href="{$ShopURL}/{$templateDir}js/app/globals.js" as="script" crossorigin>
            <link rel="modulepreload" href="{$ShopURL}/{$templateDir}js/app/snippets/form-counter.js" as="script" crossorigin>
            <link rel="modulepreload" href="{$ShopURL}/{$templateDir}js/app/plugins/navscrollbar.js" as="script" crossorigin>
            <link rel="modulepreload" href="{$ShopURL}/{$templateDir}js/app/plugins/tabdrop.js" as="script" crossorigin>
            <link rel="modulepreload" href="{$ShopURL}/{$templateDir}js/app/views/header.js" as="script" crossorigin>
            <link rel="modulepreload" href="{$ShopURL}/{$templateDir}js/app/views/productdetails.js" as="script" crossorigin>
        {/block}
        {if !empty($oUploadSchema_arr)}
            <script defer src="{$ShopURL}/{$templateDir}js/fileinput/fileinput.min.js"></script>
            <script defer src="{$ShopURL}/{$templateDir}js/fileinput/themes/fas/theme.min.js"></script>
            <script defer src="{$ShopURL}/{$templateDir}js/fileinput/locales/{$uploaderLang}.js"></script>
        {/if}
        {if $Einstellungen.preisverlauf.preisverlauf_anzeigen === 'Y' && !empty($bPreisverlauf)}
            <script defer src="{$ShopURL}/{$templateDir}js/Chart.bundle.min.js"></script>
        {/if}
        <script type="module" src="{$ShopURL}/{$templateDir}js/app/app.js"></script>
    </head>
{/block}

{has_boxes position='left' assign='hasLeftPanel'}
{* KK Kategorieabfrage *}

{block name='layout-header-body-tag'}



<body class="{if $Einstellungen.template.theme.button_animated === 'Y'}btn-animated{/if}
                     {if $Einstellungen.template.theme.wish_compare_animation === 'mobile'
|| $Einstellungen.template.theme.wish_compare_animation === 'both'}wish-compare-animation-mobile{/if}
                     {if $Einstellungen.template.theme.wish_compare_animation === 'desktop'
|| $Einstellungen.template.theme.wish_compare_animation === 'both'}wish-compare-animation-desktop{/if}
                     {if $isMobile}is-mobile{/if}
                     {if $nSeitenTyp === $smarty.const.PAGE_BESTELLVORGANG} is-checkout{/if} is-nova"
      data-page="{$nSeitenTyp}"
            {if isset($Link) && !empty($Link->getIdentifier())} id="{$Link->getIdentifier()}"{/if} color-theme="{if $Brotnavi[1]->name == 'FRISEUR'}217{elseif $Brotnavi[1]->name == 'MEDIZIN'}310{else}1563{/if}" 

{/block} .
{if !$bExclusive}
    {if !$isMobile}
        {include file=$opcDir|cat:'tpl/startmenu.tpl'}
    {/if}

    {if $bAdminWartungsmodus}
        {block name='layout-header-maintenance-alert'}
            {alert show=true variant="warning" id="maintenance-mode" dismissible=true}{lang key='adminMaintenanceMode'}{/alert}
        {/block}
    {/if}
    {if $smarty.const.SAFE_MODE === true}
        {block name='layout-header-safemode-alert'}
            {alert show=true variant="warning" id="safe-mode" dismissible=true}{lang key='safeModeActive'}{/alert}
        {/block}
    {/if}

    {block name='layout-header-header'}

        {* {if $smarty.server.HTTP_REFERER|strstr:'domain=transfer&sld='} *}
        {if $smarty.server.REMOTE_ADDR == '130.180.64.138'}
            {* {get_category_parents categoryId=$activeIdFirstLayer assign='activeParentsFirstLayer'} *}
            {* <pre>{$Brotnavi[1]->name|var_dump}</pre> *}
        {/if}

        {block name='layout-header-branding-top-bar'}
            <div id="meta-bar" class="d-none topbar-wrapper {if $Einstellungen.template.megamenu.header_full_width === 'Y'}is-fullwidth{/if} {if $nSeitenTyp !== $smarty.const.PAGE_BESTELLVORGANG}d-lg-flex{/if}">
                <div class="container-fluid {if $Einstellungen.template.megamenu.header_full_width === 'N'}container-fluid-xl{/if} {if $nSeitenTyp !== $smarty.const.PAGE_BESTELLVORGANG}d-lg-flex{/if}">
                    {include file='layout/meta_bar.tpl'}
                </div>
            </div>
            <div id="header-top-bar" class="d-none topbar-wrapper {if $Einstellungen.template.megamenu.header_full_width === 'Y'}is-fullwidth{/if} {if $nSeitenTyp !== $smarty.const.PAGE_BESTELLVORGANG}d-lg-flex{/if}">
                <div class="container-fluid {if $Einstellungen.template.megamenu.header_full_width === 'N'}container-fluid-xl{/if} {if $nSeitenTyp !== $smarty.const.PAGE_BESTELLVORGANG}d-lg-flex flex-row-reverse{/if}">
                    {include file='layout/header_top_bar.tpl'}
                </div>
            </div>
        {/block}
        <header class="d-print-none {if !$isMobile || $Einstellungen.template.theme.mobile_search_type !== 'fixed'}sticky-top{/if} fixed-navbar" id="jtl-nav-wrapper">
            {block name='layout-header-container-inner'}
                <div class="container-fluid d-flex {if $Einstellungen.template.megamenu.header_full_width === 'N'}container-fluid-xl{/if}">
                    {block name='layout-header-category-nav'}
                        <div class="toggler-logo-wrapper">
                            {block name='layout-header-navbar-toggle'}
                                <button id="burger-menu" class="burger-menu-wrapper navbar-toggler collapsed {if $nSeitenTyp === $smarty.const.PAGE_BESTELLVORGANG}d-none{/if}" type="button" data-toggle="collapse" data-target="#mainNavigation" aria-controls="mainNavigation" aria-expanded="false" aria-label="Toggle navigation">
                                    <span class="navbar-toggler-icon"></span>
                                </button>
                            {/block}

                            {block name='layout-header-logo'}

                                {if ($Brotnavi[1]->name == 'KOSMETIK' && $smarty.server.REDIRECT_SCRIPT_URL != '/KOSMETIK') || ($Brotnavi[1]->name == 'FRISEUR' && $smarty.server.REDIRECT_SCRIPT_URL != '/friseurstudio-einrichtung') || ($Brotnavi[1]->name == 'MEDIZIN' && $smarty.server.REDIRECT_SCRIPT_URL != '/medizinausstattung-und-einrichtung')}
                                    {assign var="ShopHomeUrlKat" value=$Brotnavi[1]->url}
                                {else}
                                    {assign var="ShopHomeUrlKat" value=$ShopHomeURL}
                                {/if}
                            {* {if $smarty.server.REMOTE_ADDR === '130.180.64.138'}
                                <pre>{$smarty.server|var_dump}</pre>
                                <pre>{$Brotnavi[1]->name|var_dump}</pre>
                                {/if} *}

                                <div id="logo" class="logo-wrapper" itemprop="publisher" itemscope itemtype="https://schema.org/Organization">
                                    <span itemprop="name" class="d-none">{$meta_publisher}</span>
                                    <meta itemprop="url" content="{$ShopHomeURL}">
                                    <meta itemprop="logo" content="{$ShopLogoURL}">
                                    {link class="navbar-brand" href=$ShopHomeUrlKat title=$Einstellungen.global.global_shopname}
                                    {if isset($ShopLogoURL)}
                                        {* {image width=180 height=50 src=$ShopLogoURL
                                        alt=$Einstellungen.global.global_shopname
                                        id="shop-logo"
                                        class="img-aspect-ratio"
                                        } *}
                                        {*                                        <img width=180 height=50 src={$ShopHomeURL}/media/image/opc/lg/Logos/BEAUTEK_logo_black_RGB.svg*}
                                        {*                                             alt=$Einstellungen.global.global_shopname*}
                                        {*                                             id="shop-logo"*}
                                        {*                                             class="img-aspect-ratio beautek-logo logo-black d-none">*}
                                        {*                                        <img width=180 height=50 src={$ShopHomeURL}/media/image/opc/lg/Logos/BEAUTEK_logo_mint_RGB.svg*}
                                        {*                                             alt=$Einstellungen.global.global_shopname*}
                                        {*                                             id="shop-logo"*}
                                        {*                                             class="img-aspect-ratio beautek-logo logo-mint d-none">*}

                                        <svg fill="currentColor" width="163.175" height="28.875" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 652.7 115.5" style="enable-background:new 0 0 652.7 115.5;" xml:space="preserve">
                                        <g>
                                            <polygon points="285.6,63.8 285.6,52 246.9,52 246.9,63.8 	"/>
                                            <path d="M430.6,24.5v37.3c0,7.2-2.2,12.3-6.8,15.2c-3.6,2.3-9.2,3.5-16.9,3.5c-9.2,0-15.6-0.8-19.3-2.5
                                                c-5.6-2.6-8.4-8-8.4-16.2V24.5h-11.8v37.3c0,10.9,3.3,18.9,9.8,23.9c5.8,4.4,14.3,6.6,25.6,6.6h4.1c11.3,0,19.9-2.2,25.6-6.6
                                                c6.5-5,9.8-13,9.8-23.9V24.5l0,0H430.6z"/>
                                            <path d="M336,31c-1-1.7-2.3-3.2-3.9-4.5c-1.5-1.3-3.4-2.1-5.4-2.2c-2,0.2-3.9,1-5.4,2.3c-1.5,1.2-2.9,2.7-3.9,4.4
                                                l-29.7,49.6h-45.8V36.3h46.8V24.5h-58.6v67.8h58.6v0h7.1L326.5,42l11.8,19.5h-17.9l-7.1,11.8h32.2l11.3,19H372L336,31L336,31z"/>
                                            <polygon points="442.5,36.3 471.7,36.3 471.7,92.3 483.4,92.3 483.4,36.3 510.1,36.3 510.1,24.5 510.2,24.5
                                                442.5,24.5 	"/>
                                            <path d="M216.6,58.7c7.4-5.5,9.2-15.7,4.4-23.5c-4.6-7.2-12.7-10.8-24.3-10.8h-48.6v11.7l50.3,0.3c3,0,6,0.5,8.8,1.7
                                                c3.7,1,5.8,4.9,4.7,8.5c-0.7,2.3-2.4,4-4.7,4.7c-2.8,1.2-5.8,1.8-8.8,1.8h-37.5v11.8h37.6c3,0,5.9,0.5,8.6,1.6
                                                c3.5,1.5,5.2,3.6,5.2,6.4c0,2.8-1.7,4.9-5.2,6.3c-2.8,1-5.7,1.5-8.6,1.5h-50.4l0,11.7v0h48.5c12.2,0,20.5-3.8,24.8-11.4
                                                c1.4-2.5,2.2-5.3,2.2-8.2C223.8,67.1,221.1,61.9,216.6,58.7z"/>
                                            <path d="M612.2,59.1l40.5-34.6h-17.4l-33.7,28.9c-3,1.4-4.3,4.9-2.9,7.9c0.6,1.3,1.6,2.3,2.9,2.9l33.7,28.1h17.3
                                                L612.2,59.1L612.2,59.1z"/>
                                            <polygon points="596,24.5 584.2,24.5 584.2,92.3 596.1,92.3 596,24.5 	"/>
                                            <polygon points="517.2,92.3 575.8,92.3 575.8,80.5 575.8,80.5 529,80.5 529,36.3 575.8,36.3 575.8,24.5 517.2,24.5
                                                "/>
                                            <polygon points="534,63.8 572.7,63.8 572.7,52 534,52 	"/>
                                        </g>
                                        <path d="M110.9,35.2C98.5,5.9,64.6-7.8,35.2,4.6S-7.8,50.9,4.6,80.2s46.3,43.1,75.7,30.7S123.3,64.6,110.9,35.2
                                            L110.9,35.2z M97,67.3c-2,6.9-9.3,11.6-16.4,11.4c-3.9-0.1-7.5-1.5-10.6-3.9c-1.2-1-2.6-2.4-4.1-3.5l2.1,5.2
                                            c0.6,1.6-0.7,3.3-2.1,3.7c-1.7,0.5-3.2-0.7-3.7-2.1c-0.3-0.8-0.6-1.5-0.9-2.3c-0.3-0.7-0.6-1.4-0.8-2.1c-0.2,1.6-0.2,3.3-0.4,4.7
                                            c-0.5,3.6-1.8,6.9-4.2,9.7c-4.7,5.4-13.2,7.4-19.8,4.2c-3-1.4-5.6-4.2-6.3-7.4c-0.5-2.4,0.3-4.8,1.3-6.9c1-2.3,2.4-4.4,3.8-6.4
                                            c-1.5,0.5-3,0.9-4.6,1c-3.7,0.2-6.8-1.5-9.1-4.4c-1.9-2.5-2.9-6-5.4-8.1c-2.7-2.3-6.7-4.1-5.5-8.5c1.1-4.1,6-4.1,9.4-4.2
                                            c4.3,0,8.6,0.5,12.8,1.4c7.9,1.8,15.2,5.4,21.6,10.4c0,0,0,0,0.1,0c0.2,0.1,0.5,0.2,0.7,0.4c-0.4-1.5,0.8-3,2.2-3.5
                                            c1.4-0.5,2.7,0.3,3.4,1.4c0.1-0.2,0.2-0.5,0.2-0.7c1-7.8,3.8-15.5,8.1-22.1c2.1-3.3,4.6-6.5,7.4-9.2c2.5-2.5,5.9-6.3,9.8-5.1
                                            c4,1.2,4.1,5.6,3.3,9c-0.9,4,1.2,7.5,1.5,11.5c0.3,4-1.4,7.5-4.7,9.8c-0.9,0.6-1.8,1.1-2.7,1.6C91.7,53.9,100,57.1,97,67.3L97,67.3z
                                            "/>
                                        </svg>

                                    {else}
                                        <span class="h1">{$Einstellungen.global.global_shopname}</span>
                                    {/if}
                                    {/link}
                                </div>
                            {/block}
                        </div>

                        {block name="first-layer-navigation"}
                            {if $nSeitenTyp != $smarty.const.PAGE_BESTELLVORGANG}
                                <div class="container mr-0">
                                    <div class="row">
                                        <div class="col d-none d-lg-flex">
                                            <div class="shop-first-layer-navigation">
                                                {get_category_array categoryId=0 assign='categoriesFirstLayer'}

                                                {if !empty($categoriesFirstLayer)}
                                                    {if !isset($activeIdFirstLayer)}
                                                        {if isset($NaviFilter->Kategorie) && intval($NaviFilter->Kategorie->kKategorie) > 0}
                                                            {$activeIdFirstLayer = $NaviFilter->Kategorie->kKategorie}
                                                        {elseif $nSeitenTyp == 1 && isset($Artikel)}
                                                            {assign var='activeIdFirstLayer' value=$Artikel->gibKategorie()}
                                                        {elseif $nSeitenTyp == 1 && isset($smarty.session.LetzteKategorie)}
                                                            {$activeIdFirstLayer = $smarty.session.LetzteKategorie}
                                                        {else}
                                                            {$activeIdFirstLayer = 0}
                                                        {/if}
                                                    {/if}
                                                    {if !isset($activeParentsFirstLayer) && ($nSeitenTyp == 1 || $nSeitenTyp == 2)}
                                                        {get_category_parents categoryId=$activeIdFirstLayer assign='activeParentsFirstLayer'}
                                                    {/if}



                                                    {if $activeIdFirstLayer != 1563 && $activeIdFirstLayer != 217 && $activeIdFirstLayer != 310 && (isset($activeParentsFirstLayer[0]) && $activeParentsFirstLayer[0]->kKategorie != 1563) && (isset($activeParentsFirstLayer[0]) && $activeParentsFirstLayer[0]->kKategorie != 217) && (isset($activeParentsFirstLayer[0]) && $activeParentsFirstLayer[0]->kKategorie != 310)}
                                                        {$activeIdFirstLayer = 1563}
                                                    {/if}


                                                    <ul class="first-layer-menu-list">
                                                        {foreach name="categoriesFirstLayer" from=$categoriesFirstLayer item='category'}

                                                            {if $category->parentID === 0}

                                                                <li class="nav-item {if $category->cKurzbezeichnung == 'Kosmetik' && $activeIdFirstLayer == 0}active{/if}{if $category->kKategorie == $activeIdFirstLayer || (isset($activeParentsFirstLayer[0]) && $activeParentsFirstLayer[0]->kKategorie == $category->kKategorie)} active{/if}">
                                                                    <a data-id="{$category->kKategorie}" href="{$category->cURL}" class="nav-link">
                                                                        {$category->cKurzbezeichnung}
                                                                    </a>
                                                                </li>

                                                            {/if}
                                                        {/foreach}
                                                    </ul>

                                                {/if}
                                            </div>
                                        </div>
                                        {block name='layout-header-branding-shop-nav'}
                                            {nav id="shop-nav" right=true class="nav-right order-lg-last nav-icons"}
                                                {include file='layout/header_nav_icons.tpl'}
                                                {block name='layout-header-branding-shop-nav-include-language-dropdown'}
                                                    {include file='snippets/language_dropdown.tpl' dropdownClass='d-flex d-lg-none'}
                                                {/block}
                                                {if $isMobile}
                                                    {include file='layout/meta_bar.tpl'}
                                                {/if}
                                            {/nav}
                                        {/block}
                                    </div>
                                </div>
                                <div class="container-fluid container-fluid-xl">
                                    <div class="row mainNavigation-wrapper">
                                        {*categories*}
                                        {block name='layout-header-include-categories-mega'}
                                            <div id="mainNavigation" class="navbar-collapse nav-scrollbar">
                                                {block name='layout-header-include-include-categories-header'}
                                                    <div class="nav-mobile-header d-lg-none">
                                                        {row class="align-items-center-util"}
                                                        {col class="nav-mobile-header-toggler"}
                                                        {block name='layout-header-include-categories-mega-toggler'}
                                                            <button class="navbar-toggler collapsed" type="button" data-toggle="collapse" data-target="#mainNavigation" aria-controls="mainNavigation" aria-expanded="false" aria-label="Toggle navigation">
                                                                <span class="navbar-toggler-icon"></span>
                                                            </button>
                                                        {/block}
                                                        {/col}
                                                        {col class="col-auto nav-mobile-header-name ml-auto-util"}
                                                            <span class="nav-offcanvas-title">{lang key='menuName'}</span>
                                                        {block name='layout-header-include-categories-mega-back'}
                                                            {link href="#" class="nav-offcanvas-title d-none" data=["menu-back"=>""]}
                                                                <span class="fas fa-chevron-left icon-mr-2"></span>
                                                                <span>{lang key='back'}</span>
                                                            {/link}
                                                        {/block}
                                                        {/col}
                                                        {/row}
                                                        <hr class="nav-mobile-header-hr" />
                                                    </div>
                                                {/block}
                                                {block name='layout-header-include-include-categories-body'}
                                                    <div class="nav-mobile-body">

                                                        <div class="offcanvas-first-layer d-lg-none">
                                                            <ul class="first-layer-menu-list">
                                                                {foreach name="categoriesFirstLayer" from=$categoriesFirstLayer item='category'}
                                                                    {if $category->parentID === 0}

                                                                        <li class="nav-item {if $category->kKategorie == $activeIdFirstLayer || (isset($activeParentsFirstLayer[0]) && $activeParentsFirstLayer[0]->kKategorie == $category->kKategorie)} active{/if}">
                                                                            <a  href="{$category->cURL}" class="nav-link" data-id="{$category->kKategorie}">
                                                                                {$category->cKurzbezeichnung}
                                                                            </a>
                                                                        </li>

                                                                    {/if}
                                                                {/foreach}
                                                            </ul>
                                                        </div>

                                                        {assign var='startIdCategories' value=1563}

                                                        {if isset($activeParentsFirstLayer) && !empty($activeParentsFirstLayer)}
                                                            {$startIdCategories = $activeParentsFirstLayer[0]->kKategorie}
                                                        {else}
                                                            {$startIdCategories = $activeIdFirstLayer}
                                                        {/if}

                                                        {if $startIdCategories != 1563 && $startIdCategories != 217 && $startIdCategories != 310}
                                                            {$startIdCategories = 1563}
                                                        {/if}

                                                        {navbarnav class="nav-scrollbar-inner mr-auto flex-lg-row "}
                                                        {block name='layout-header-include-include-categories-mega'}
                                                            {* {include file='snippets/categories_mega_nav.tpl' startId=$startIdCategories} *}
                                                            {include file='snippets/categories_mega.tpl' startId=$startIdCategories}
                                                        {/block}
                                                        {/navbarnav}

                                                    </div>
                                                {/block}
                                            </div>
                                        {/block}
                                    </div>
                                    {navbar toggleable=true fill=true type="expand-lg" class="justify-content-start {if $nSeitenTyp === $smarty.const.PAGE_BESTELLVORGANG}align-items-center-util{else}align-items-lg-start{/if}"}
                                    {block name='layout-header-search'}
                                        {if $Einstellungen.template.theme.mobile_search_type === 'fixed'}
                                            <div class="d-lg-none search-form-wrapper-fixed container-fluid container-fluid-xl order-1">
                                                {include file='snippets/search_form.tpl' id='search-header-mobile-top'}
                                            </div>
                                        {/if}
                                    {/block}

                                    {if $nSeitenTyp === $smarty.const.PAGE_BESTELLVORGANG}
                                        {block name='layout-header-secure-checkout'}
                                            <div class="secure-checkout-icon ml-auto-util ml-lg-0">
                                                {block name='layout-header-secure-checkout-title'}
                                                    <i class="fas fa-lock icon-mr-2"></i>{lang key='secureCheckout' section='checkout'}
                                                {/block}
                                            </div>
                                            <div class="secure-checkout-topbar ml-auto-util d-none d-lg-block">
                                                {block name='layout-header-secure-include-header-top-bar'}
                                                    {include file='layout/header_top_bar.tpl'}
                                                {/block}
                                            </div>
                                        {/block}



                                    {/if}
                                    {/navbar}

                                </div>

                            {/if}
                        {/block}

                    {/block}
                </div>
            {/block}
        </header>
        {block name='layout-header-search-fixed'}
            {if $Einstellungen.template.theme.mobile_search_type === 'fixed' && $isMobile}
                <div class="container-fluid container-fluid-xl fixed-search fixed-top smoothscroll-top-search d-lg-none d-none">
                    {include file='snippets/search_form.tpl' id='search-header-mobile-fixed'}
                </div>
            {/if}
        {/block}
    {/block}
{/if}

{block name='layout-header-main-wrapper-starttag'}
<main id="main-wrapper" class="{if $bExclusive} exclusive{/if}{if $hasLeftPanel} aside-active{/if}">
    {opcMountPoint id='opc_before_main' inContainer=false}
    {/block}

    {block name='layout-header-fluid-banner'}
        {assign var=isFluidBanner value=$Einstellungen.template.theme.banner_full_width === 'Y' && isset($oImageMap)}
        {if $isFluidBanner}
            {block name='layout-header-fluid-banner-include-banner'}
                {include file='snippets/banner.tpl' isFluid=true}
            {/block}
        {/if}
        {assign var=isFluidSlider value=$Einstellungen.template.theme.slider_full_width === 'Y' && isset($oSlider) && count($oSlider->getSlides()) > 0}
        {if $isFluidSlider}
            {block name='layout-header-fluid-banner-include-slider'}
                {include file='snippets/slider.tpl' isFluid=true}
            {/block}
        {/if}
    {/block}

    {block name='layout-header-content-all-starttags'}
    {block name='layout-header-content-wrapper-starttag'}
    <div id="content-wrapper"
         class="{if ($Einstellungen.template.theme.left_sidebar === 'Y' && $boxesLeftActive) || $smarty.const.PAGE_ARTIKELLISTE === $nSeitenTyp}has-left-sidebar container-fluid container-fluid-xl{/if}
                 {if $smarty.const.PAGE_ARTIKELLISTE === $nSeitenTyp}is-item-list{/if}
                        {if $isFluidBanner || $isFluidSlider} has-fluid{/if}">
        {/block}

        {block name='layout-header-breadcrumb'}
            {container fluid=(($Einstellungen.template.theme.left_sidebar === 'Y' && $boxesLeftActive) || $smarty.const.PAGE_ARTIKELLISTE === $nSeitenTyp || (isset($Link) && $Link->getIsFluid())) class="breadcrumb-container"}
                {include file='layout/breadcrumb.tpl'}
            {/container}
        {/block}

        {block name='layout-header-content-starttag'}
        <div id="content">
            {/block}

            {if !$bExclusive && !empty($boxes.left|strip_tags|trim) && (($Einstellungen.template.theme.left_sidebar === 'Y' && $boxesLeftActive) || $smarty.const.PAGE_ARTIKELLISTE === $nSeitenTyp)}
            {block name='layout-header-content-productlist-starttags'}
            <div class="row">
                <div class="col-lg-8 col-xl-9 ml-auto-util order-lg-1">
                    {/block}
                    {/if}

                    {block name='layout-header-alert'}
                        {include file='snippets/alert_list.tpl'}
                    {/block}

                    {/block}{* /content-all-starttags *}
                    {/block}
