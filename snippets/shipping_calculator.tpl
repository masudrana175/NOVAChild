{extends file="{$parent_template_path}/snippets/shipping_calculator.tpl"}

{*
  Beautek: Im Warenkorb (compact=true) wird der Versandrechner kompakt und
  ohne sichtbares PLZ-Feld dargestellt. Statt einer Eingabe wird je gewähltem
  Land eine repräsentative Standard-PLZ als Hidden-Feld mitgeschickt (siehe Map
  unten), damit der Versand ohne Tipparbeit geschätzt werden kann. Die PLZ folgt
  automatisch der Länderauswahl.
  Überall sonst (Versandseite, Checkout) bleibt das Original unverändert.
*}

{* Kompakte, kleine Überschrift (ohne große h3-Klasse). *}
{block name='snippets-shipping-calculator-estimate'}
    {if $compact|default:false}
        <div class="shipping-calculator-main-heading small text-muted-util">Versand berechnen nach:</div>
    {else}
        {$smarty.block.parent}
    {/if}
{/block}

{* Ergebnis-Tabelle (Versandarten + Speditionstext) im Warenkorb ausblenden –
   der ermittelte Betrag steht unten in der Bestellübersicht. Das Ergebnis wird
   serverseitig trotzdem berechnet ($Versandarten), nur nicht hier gerendert. *}
{block name='snippets-shipping-calculator-content'}
    {if $compact|default:false}{else}{$smarty.block.parent}{/if}
{/block}

{block name='snippets-shipping-calculator-countries'}
    {if $compact|default:false}
        {* Standardland = bereits gewähltes Land, sonst Deutschland (DE). *}
        {$beautekSelCountry = $shippingCountry}
        {if !$beautekSelCountry}{$beautekSelCountry = 'DE'}{/if}
        {col cols=12 class="shipping-calculator-main-country"}
            {formgroup}
                {select name="land" id="country" class='custom-select' placeholder="" aria=["label"=>"{lang key='country' section='account data'}"]}
                    {* Häufigste Lieferländer zuerst, in fester Reihenfolge. *}
                    {foreach ['DE','AT','CH'] as $beautekTopIso}
                        {foreach $countries as $country}
                            {if $country->getISO() === $beautekTopIso && $country->isShippingAvailable()}
                                <option value="{$country->getISO()}" {if $beautekSelCountry === $country->getISO()}selected{/if}>{$country->getName()}</option>
                            {/if}
                        {/foreach}
                    {/foreach}
                    {* Trennlinie *}
                    <option disabled>──────────</option>
                    {* Alle übrigen Länder *}
                    {foreach $deliverableCountries as $country}
                        {if $country->isShippingAvailable()
                            && $country->getISO() !== 'DE'
                            && $country->getISO() !== 'AT'
                            && $country->getISO() !== 'CH'}
                            <option value="{$country->getISO()}" {if $beautekSelCountry === $country->getISO()}selected{/if}>{$country->getName()}</option>
                        {/if}
                    {/foreach}
                {/select}
            {/formgroup}
        {/col}
    {else}
        {$smarty.block.parent}
    {/if}
{/block}

{block name='snippets-shipping-calculator-submit'}
    {if $compact|default:false}
        {*
          Repräsentative Standard-PLZ je Land, damit der Versand ohne PLZ-Eingabe
          geschätzt werden kann. Die PLZ folgt automatisch der Länderauswahl
          (serverseitig beim Render + per JS bei Dropdown-Wechsel).
          Bei Bedarf hier erweitern/anpassen.
        *}
        {$beautekPlzMap = [
            'DE' => '57072', 'AT' => '1010', 'CH' => '8001', 'LI' => '9490',
            'LU' => '1009', 'NL' => '1011', 'BE' => '1000', 'FR' => '75001',
            'IT' => '00118', 'ES' => '28001', 'DK' => '1050', 'PL' => '00001',
            'CZ' => '11000', 'SE' => '11120', 'FI' => '00100'
        ]}
        {$beautekFallbackPlz = '10115'}
        {$beautekSelIso = $shippingCountry}
        {if !$beautekSelIso}{$beautekSelIso = 'DE'}{/if}
        {$beautekPlz = $beautekPlzMap[$beautekSelIso]|default:$beautekFallbackPlz}
        <input type="hidden" name="plz" id="beautek-ship-plz" value="{$beautekPlz}">
        {* Kein sichtbarer Button mehr: Die Versandermittlung wird automatisch
           durch die Länderauswahl ausgelöst. Der versteckte Submit-Button trägt
           den nötigen versandrechnerBTN-Parameter und wird per JS geklickt. *}
        <button type="submit" name="versandrechnerBTN" value="1" id="beautek-ship-submit" style="display:none" tabindex="-1" aria-hidden="true"></button>
        <script>
        (function () {
            // Nach einer automatischen Versandermittlung (Full-Reload) wieder ganz
            // nach oben scrollen, statt zum Formular/zur Übersicht zu springen.
            try {
                if (sessionStorage.getItem('beautekShipScrollTop')) {
                    sessionStorage.removeItem('beautekShipScrollTop');
                    if ('scrollRestoration' in history) { history.scrollRestoration = 'manual'; }
                    window.scrollTo(0, 0);
                    window.addEventListener('load', function () { window.scrollTo(0, 0); });
                }
            } catch (e) {}

            var form = document.getElementById('basket-shipping-estimate-form');
            if (!form) { return; }
            var sel = form.querySelector('#country');
            var plz = form.querySelector('#beautek-ship-plz');
            var map = {
                DE: '57072', AT: '1010', CH: '8001', LI: '9490',
                LU: '1009', NL: '1011', BE: '1000', FR: '75001',
                IT: '00118', ES: '28001', DK: '1050', PL: '00001',
                CZ: '11000', SE: '11120', FI: '00100'
            };
            var fallback = '10115';
            function sync() { if (sel && plz) { plz.value = map[sel.value] || fallback; } }

            // Versandrechner (per Klick auf den versteckten Submit-Button) auslösen.
            // Element wird frisch geholt, da der Warenkorb per AJAX neu gerendert wird.
            function triggerEstimate() {
                var f = document.getElementById('basket-shipping-estimate-form');
                if (!f) { return; }
                var b = f.querySelector('[name="versandrechnerBTN"]');
                window.__beautekEstimating = true;
                // Loop-Schutz + Scroll-Flag setzen (überlebt Reload/Redirect):
                //  - Cookie beautek_ship_auto verhindert erneutes Auto-Ermitteln nach
                //    dem Reload (sonst Dauerladen, wenn der Status weiter "nicht
                //    berechnet" ist). Kurzlebig (60s), damit es sich selbst heilt.
                //  - beautekShipScrollTop sorgt fürs Hochscrollen nach dem Reload.
                try { document.cookie = 'beautek_ship_auto=1;path=/;max-age=60'; } catch (e) {}
                try { sessionStorage.setItem('beautekShipScrollTop', '1'); } catch (e) {}
                if (b) { b.click(); }
                else if (window.jQuery) { window.jQuery(f).trigger('submit'); }
            }

            var calculated = {if !empty($Versandarten)}true{else}false{/if};

            // Bei Erfolg (Versand wurde berechnet) den Loop-Schutz zurücksetzen,
            // damit die nächste echte Änderung wieder genau eine Ermittlung darf.
            if (calculated) {
                try { document.cookie = 'beautek_ship_auto=;path=/;max-age=0'; } catch (e) {}
            }

            // Sichtbare Shop-Hinweise (z. B. Kupon-Fehler) – dann keinen Auto-Reload,
            // sonst verschwindet die Meldung sofort wieder.
            function hasVisibleAlerts() {
                return !!document.querySelector(
                    '#alert-list .alert, .alert-danger, .alert-warning, .basket-coupon-accordion__error, .basket-coupon-panel__error'
                );
            }

            // Genau EINE automatische Ermittlung pro Warenkorb-Zustand, mit hartem
            // Loop-Schutz gegen Dauerladen: Wurde bereits versucht (beautekShipAuto
            // gesetzt) und ist der Status weiterhin "nicht berechnet" – z. B. Land
            // ohne Versandart oder aktiver Seiten-Cache –, wird NICHT erneut geladen.
            function autoEstimate() {
                if (calculated) { return; }
                // Loop-Schutz: schon versucht? (Cookie übersteht Reload/Redirect.)
                if (document.cookie.indexOf('beautek_ship_auto=1') !== -1) { return; }
                if (hasVisibleAlerts()) { return; }
                triggerEstimate();
            }

            // Länderwechsel -> PLZ angleichen und bewusst neu ermitteln. Der
            // Loop-Schutz wird hier aufgehoben, da es eine echte Nutzeraktion ist.
            if (sel && plz) {
                sync();
                var ctTimer = null;
                sel.addEventListener('change', function () {
                    sync();
                    try { document.cookie = 'beautek_ship_auto=;path=/;max-age=0'; } catch (e) {}
                    if (ctTimer) { clearTimeout(ctTimer); }
                    ctTimer = setTimeout(triggerEstimate, 350);
                });
            }

            // 1) Beim ersten Laden einmalig automatisch ermitteln (loop-sicher).
            if (!window.__beautekShipInit) {
                window.__beautekShipInit = true;
                if (window.jQuery) { window.jQuery(autoEstimate); }
                else { setTimeout(autoEstimate, 120); }
            }

            // 2) Bei Warenkorb-Änderung (Menge/Artikel) genau einmal neu ermitteln.
            //    Loop-Schutz wird aufgehoben (echte Änderung); der eigene
            //    Rechner-Request wird ausgenommen, damit keine Schleife entsteht.
            //    Kupon-Requests bewusst auslassen: sonst überschreibt ein zweiter
            //    Reload den Kupon-Hinweis, bevor man ihn lesen kann.
            if (window.jQuery && !window.__beautekShipBound) {
                window.__beautekShipBound = true;
                var debTimer = null;
                window.jQuery(document).on('ajaxComplete', function (e, xhr, settings) {
                    if (window.__beautekEstimating) { window.__beautekEstimating = false; return; }
                    var data = (settings && settings.data) ? String(settings.data) : '';
                    var url = (settings && settings.url) ? String(settings.url) : '';
                    if (data.indexOf('versandrechnerBTN') !== -1) { return; }
                    if (data.indexOf('Kuponcode') !== -1) { return; }
                    if (url.indexOf('warenkorb') === -1 && data.indexOf('wka') === -1) { return; }
                    if (!document.getElementById('basket-shipping-estimate-form')) { return; }
                    if (hasVisibleAlerts()) { return; }
                    try { document.cookie = 'beautek_ship_auto=;path=/;max-age=0'; } catch (e) {}
                    if (debTimer) { clearTimeout(debTimer); }
                    debTimer = setTimeout(triggerEstimate, 300);
                });
            }
        })();
        </script>
    {else}
        {$smarty.block.parent}
    {/if}
{/block}
