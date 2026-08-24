{extends file="{$parent_template_path}/basket/index.tpl"}

{*
  Beautek – Shopify-Style Bestellübersicht im Warenkorb.
  Überschreibt die ECHTEN NOVA-Blöcke aus basket/index.tpl.

  Versand:
    - Quelle ist das FRISCHE Rechner-Ergebnis ($Versandarten), NICHT der
      gecachte/fehleranfällige favourableShippingString.
    - Im Brutto-Modus (NettoPreise == 0) wird der Versand zusätzlich in die
      Gesamtsumme eingerechnet (Artikel + ermittelter Versand).
    - Solange noch nicht ermittelt: Hinweis "wird berechnet".
*}

{block name='basket-index-price-tax'}
    {* One-Page-Checkout-Vorschau: Cookie kommt aus header.tpl / inc_opc_flag.tpl
       Aktivieren:   <Shop-URL>/Warenkorb?opc=beautek-opc-2026
       Deaktivieren: <Shop-URL>/Warenkorb?opc=off *}
    {include file='checkout/inc_opc_flag.tpl' beautekOpcEmitCookie=false beautekOpcShowBanner=true}

    {$beautekCur = JTL\Session\Frontend::getCurrency()}
    {$beautekDec = $beautekCur->getDecimalSeparator()}
    {$beautekTho = $beautekCur->getThousandsSeparator()}

    {* Günstigste frisch ermittelte Versandart aus dem Rechner-Ergebnis *}
    {$beautekShipNum = ''}
    {$beautekShipStr = ''}
    {if !empty($Versandarten)}
        {foreach $Versandarten as $beautekVa}
            {$beautekN = $beautekVa->cPreisLocalized|replace:$beautekTho:''|replace:$beautekDec:'.'|regex_replace:'/[^0-9.]/':''}
            {if $beautekN !== '' && ($beautekShipNum === '' || ($beautekN + 0) < ($beautekShipNum + 0))}
                {$beautekShipNum = $beautekN}
                {$beautekShipStr = $beautekVa->cPreisLocalized}
            {/if}
        {/foreach}
    {/if}

    {* Rabatt aus Kupon-Positionen (Kupon + Neukundenkupon) ermitteln.
       WarensummeLocalized enthält den Rabatt bereits -> wir rechnen ihn für die
       "Zwischensumme vor Rabatt" wieder heraus und zeigen ihn als eigene Zeile. *}
    {$beautekDiscNum = 0}
    {$beautekDiscStr = ''}
    {$beautekDiscName = ''}
    {foreach JTL\Session\Frontend::getCart()->PositionenArr as $beautekPos}
        {if $beautekPos->nPosTyp === $smarty.const.C_WARENKORBPOS_TYP_KUPON
            || $beautekPos->nPosTyp === $smarty.const.C_WARENKORBPOS_TYP_NEUKUNDENKUPON}
            {$beautekPosStr = $beautekPos->cGesamtpreisLocalized[$NettoPreise][$smarty.session.cWaehrungName]}
            {$beautekPosNum = $beautekPosStr|replace:$beautekTho:''|replace:$beautekDec:'.'|regex_replace:'/[^0-9.\-]/':''}
            {if $beautekPosNum !== '' && $beautekPosNum !== '-'}
                {$beautekDiscNum = $beautekDiscNum + ($beautekPosNum + 0)}
                {$beautekDiscStr = $beautekPosStr}
                {$beautekDiscName = $beautekPos->cName|transByISO}
            {/if}
        {/if}
    {/foreach}

    {* ---------------------------------------------------------------
       Einheitliche USt-/Summen-Logik:
       - Netto-Modus: Zeilen netto, USt als eigener Betrag (Ware + Versand),
         Gesamtsumme brutto.
       - Brutto-Modus: Zeilen brutto, enthaltene USt nur informativ.
       Datenbasis: WarensummeLocalized[0]=brutto, [1]=netto (jeweils inkl. Rabatt).
       --------------------------------------------------------------- *}
    {$beautekNetGoods = $WarensummeLocalized[1]|replace:$beautekTho:''|replace:$beautekDec:'.'|regex_replace:'/[^0-9.\-]/':''}
    {$beautekGrossGoods = $WarensummeLocalized[0]|replace:$beautekTho:''|replace:$beautekDec:'.'|regex_replace:'/[^0-9.\-]/':''}
    {$beautekNetGoods = $beautekNetGoods + 0}
    {$beautekGrossGoods = $beautekGrossGoods + 0}
    {$beautekVatGoods = $beautekGrossGoods - $beautekNetGoods}
    {$beautekRate = 1}
    {if $beautekNetGoods > 0}{$beautekRate = $beautekGrossGoods / $beautekNetGoods}{/if}

    {* USt-Satz fürs Label nur bei genau einem Steuersatz anzeigen. *}
    {$beautekVatPct = ''}
    {if $Steuerpositionen|count == 1}
        {foreach $Steuerpositionen as $beautekStp}
            {$beautekVatPct = $beautekStp->cName|regex_replace:'/[^0-9.,%]/':''}
        {/foreach}
    {/if}

    {* Versand netto/brutto, Gesamt-USt (Ware + Versand) und Bruttosumme. *}
    {$beautekShipDisp = 0}
    {if $beautekShipNum !== ''}{$beautekShipDisp = $beautekShipNum + 0}{/if}
    {if $NettoPreise}
        {$beautekShipNet = $beautekShipDisp}
        {$beautekShipGross = $beautekShipDisp * $beautekRate}
    {else}
        {$beautekShipGross = $beautekShipDisp}
        {$beautekShipNet = $beautekShipDisp}
        {if $beautekRate != 0}{$beautekShipNet = $beautekShipDisp / $beautekRate}{/if}
    {/if}
    {$beautekVatShip = $beautekShipGross - $beautekShipNet}
    {$beautekVatTotal = $beautekVatGoods + $beautekVatShip}
    {$beautekGrossTotal = $beautekGrossGoods + $beautekShipGross}
    {$beautekNetTotal = $beautekNetGoods + $beautekShipNet}

    <div class="basket-order-summary">
        <div class="basket-order-summary__lines">
            {if $NettoPreise || $beautekDiscNum != 0}
                {block name='basket-index-price-net'}
                    {$beautekSubBase = $WarensummeLocalized[$NettoPreise]|replace:$beautekTho:''|replace:$beautekDec:'.'|regex_replace:'/[^0-9.\-]/':''}
                    <div class="basket-order-summary__line basket-order-summary__line--muted">
                        <span class="basket-order-summary__label">{lang key='subtotal' section='account data'}{if $NettoPreise} ({lang key='net'}){/if}</span>
                        <span class="basket-order-summary__value">
                            {if $beautekDiscNum != 0}
                                {$beautekSubPre = ($beautekSubBase + 0) - $beautekDiscNum}
                                {$beautekSubPre|beautekPrice}
                            {else}
                                {$WarensummeLocalized[$NettoPreise]}
                            {/if}
                        </span>
                    </div>
                {/block}
            {/if}

            {if $beautekDiscNum != 0}
                {block name='basket-index-discount'}
                    <div class="basket-order-summary__line basket-order-summary__line--discount">
                        <span class="basket-order-summary__label">{if $beautekDiscName !== ''}{$beautekDiscName}{else}Rabatt{/if}</span>
                        <span class="basket-order-summary__value">{$beautekDiscStr}</span>
                    </div>
                {/block}
            {/if}

            {if isset($smarty.session.Bestellung->GuthabenNutzen) && $smarty.session.Bestellung->GuthabenNutzen == 1}
                {block name='basket-index-credit'}
                    <div class="basket-order-summary__line basket-order-summary__line--discount">
                        <span class="basket-order-summary__label">{lang key='useCredit' section='account data'}</span>
                        <span class="basket-order-summary__value">{$smarty.session.Bestellung->GutscheinLocalized}</span>
                    </div>
                {/block}
            {/if}

            {* Versand – frisch aus dem Rechner *}
            <div class="basket-order-summary__line basket-order-summary__line--shipping">
                <span class="basket-order-summary__label">
                    {lang key='shipping' section='basket'}{if $NettoPreise} ({lang key='net'}){/if}
                    {if isset($oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND])}
                        <a href="{$oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND]->getURL()}?shipping_calculator=1"
                           class="basket-order-summary__shipping-link shipment popup" rel="nofollow">
                            {lang key='shippingInfo' section='login'}
                        </a>
                    {/if}
                </span>
                <span class="basket-order-summary__value basket-order-summary__value--est">
                    {if $beautekShipStr !== ''}
                        {$beautekShipNum|beautekPrice}
                    {else}
                        <span class="text-muted-util">Bitte berechnen</span>
                    {/if}
                </span>
            </div>
        </div>

        {* Versandrechner direkt in die Übersicht integriert (statt separater Box). *}
        {if $Einstellungen.kaufabwicklung.warenkorb_versandermittlung_anzeigen === 'Y'}
            {get_static_route id='warenkorb.php' assign='cartURL'}
            <div class="basket-order-summary__shipping-calc basket-summary-shipping-calc">
                {opcMountPoint id='opc_before_shipping_calculator'}
                {form id="basket-shipping-estimate-form" class="shipping-calculator-form" method="post" action="{$cartURL}" slide=true}
                    {include file='snippets/shipping_calculator.tpl' checkout=true hrAtEnd=false compact=true}
                {/form}
            </div>
        {/if}

        {block name='basket-index-price-sticky'}
            <div class="basket-order-summary__total basket-summary-total">
                <div class="basket-order-summary__total-row">
                    <span class="basket-order-summary__total-label">{lang key='totalSum'}{if $NettoPreise} ({lang key='net'}){/if}</span>
                    {* B2B: Gesamtsumme = NETTO (Ware + Versand). Solange der Versand
                       noch nicht ermittelt ist, nur die Warensumme (netto) zeigen. *}
                    {if $beautekShipNum !== ''}
                        <span class="basket-order-summary__total-value">{if $NettoPreise}{$beautekNetTotal|beautekPrice}{else}{$beautekGrossTotal|beautekPrice}{/if}</span>
                    {else}
                        <span class="basket-order-summary__total-value">{if $NettoPreise}{$beautekNetGoods|beautekPrice}{else}{$beautekGrossGoods|beautekPrice}{/if}</span>
                    {/if}
                </div>
                {* Steuer-Hinweis am Ende: B2B -> zzgl. USt., B2C -> inkl. USt.
                   Betrag nur anzeigen, wenn USt tatsächlich anfällt. *}
                <span class="basket-order-summary__tax-note small text-muted-util">
                    {if $beautekVatTotal > 0.005}
                        {if $NettoPreise}zzgl.{else}inkl.{/if} USt.{if $beautekVatPct !== ''} {$beautekVatPct}{/if}: {$beautekVatTotal|beautekPrice}
                    {else}
                        {if $NettoPreise}zzgl. USt. (falls zutreffend){else}{lang key='incl' section='productDetails'} {lang key='vat' section='productDetails'}{/if}
                    {/if}{if $beautekShipNum === ''}, {lang key='plus' section='basket'} {lang key='shipping' section='basket'}{/if}
                </span>
            </div>
        {/block}
    </div>
{/block}

{block name='basket-index-shipping'}{/block}

{* Login-Hinweis links über den Artikeln – nur Desktop, nur Gäste. *}
{block name='basket-index-include-extension'}
    {if JTL\Session\Frontend::getCustomer()->getID() === 0}
        <aside class="basket-login-hint" aria-label="Konto">
            <p class="basket-login-hint__headline">
                Logge dich ein und speichere deinen Warenkorb, damit du deine Favoriten nicht aus den Augen verlierst.
            </p>
            <p class="basket-login-hint__links">
                <a href="{get_static_route id='registrieren.php'}" rel="nofollow">Jetzt Konto erstellen</a>
                oder
                <a href="{get_static_route id='jtl.php' secure=true}" rel="nofollow">mit vorhandenem Konto anmelden</a>
            </p>
        </aside>
    {/if}
    {$smarty.block.parent}
{/block}

{* Sidebar 3: Rabattcode immer sichtbar + USPs darunter. *}
{block name='basket-index-coupon'}
    {get_static_route id='warenkorb.php' assign='cartURL'}
    {if $KuponMoeglich == 1}
        <div id="panel-edit-coupon" class="basket-coupon-panel{if !empty($invalidCouponCode)} has-error{/if}">
            <h3 class="basket-coupon-panel__title">
                <i class="fas fa-tag" aria-hidden="true"></i>
                Rabattcode
            </h3>
            {if !empty($invalidCouponCode)}
                <div class="alert alert-danger basket-coupon-panel__error" role="alert">
                    Dieser Coupon kann leider nicht angewendet werden
                    (<strong>{$invalidCouponCode|escape:'html'}</strong>).
                </div>
            {/if}
            {form class="jtl-validate basket-coupon-panel__form" id="basket-coupon-form" method="post" action=$cartURL slide=true}
                {inputgroup class="{if !empty($invalidCouponCode)}has-error{/if}"}
                    {input type="text"
                        name="Kuponcode"
                        id="couponCode"
                        maxlength="32"
                        placeholder="{lang key='couponCodePlaceholder' section='checkout'}"
                        required=true
                        value="{if !empty($invalidCouponCode)}{$invalidCouponCode}{/if}"
                        aria=["label"=>"{lang key='couponCode' section='account data'}"]
                    }
                    {inputgroupappend}
                        {button type="submit" value=1 variant="primary"}{lang key='couponSubmit' section='checkout'}{/button}
                    {/inputgroupappend}
                {/inputgroup}
            {/form}
        </div>
    {/if}

    <div class="basket-usps" aria-label="Vorteile">
        <ul class="basket-usps__list">
            <li class="basket-usps__item">
                <span class="basket-usps__icon" aria-hidden="true">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7"><path d="M16 19v-1.2A3.3 3.3 0 0 0 12.7 14.5h-1.4A3.3 3.3 0 0 0 8 17.8V19"/><circle cx="12" cy="8.5" r="2.5"/><path d="M20 19v-1A2.8 2.8 0 0 0 17.5 15.4"/><circle cx="17.5" cy="9.2" r="1.8"/><path d="M4 19v-1A2.8 2.8 0 0 1 6.5 15.4"/><circle cx="6.5" cy="9.2" r="1.8"/></svg>
                </span>
                <span class="basket-usps__text">Über 15.000<br>zufriedene Kunden</span>
            </li>
            <li class="basket-usps__item">
                <span class="basket-usps__icon" aria-hidden="true">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7"><path d="M7 3.5h7.5L19 8v12.5a1 1 0 0 1-1 1H7a1 1 0 0 1-1-1V4.5a1 1 0 0 1 1-1Z"/><path d="M14.5 3.5V8H19"/><path d="M9 12h6M9 15.5h4"/><path d="M9 18.5h2.5"/></svg>
                </span>
                <span class="basket-usps__text">Rechnungskauf &amp;<br>Finanzierung</span>
            </li>
            <li class="basket-usps__item">
                <span class="basket-usps__icon" aria-hidden="true">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7"><path d="M12 3 19.5 6.2v5.1c0 4.4-2.9 7.5-7.5 9.2-4.6-1.7-7.5-4.8-7.5-9.2V6.2L12 3Z"/><path d="m9.2 12.2 1.9 1.9 3.8-3.9"/></svg>
                </span>
                <span class="basket-usps__text">Geprüfte<br>Qualität</span>
            </li>
        </ul>
    </div>
{/block}

{block name='basket-index-side-heading'}
    <div class="h2 basket-heading">{lang key="orderOverview" section="account data"}</div>
{/block}

{* ... und aus der linken Spalte (unter den Artikeln) entfernen *}
{block name='basket-index-form-shipping-calc'}{/block}
