{include file='checkout/inc_opc_on.tpl'}
{if $beautekOpc || (isset($smarty.cookies.beautek_opc) && $smarty.cookies.beautek_opc == '1')}
    {$beautekOpcSameShip = false}
    {if isset($Kunde) && isset($Lieferadresse)
        && $Kunde->cStrasse|default:'' == $Lieferadresse->cStrasse|default:''
        && $Kunde->cHausnummer|default:'' == $Lieferadresse->cHausnummer|default:''
        && $Kunde->cPLZ|default:'' == $Lieferadresse->cPLZ|default:''
        && $Kunde->cOrt|default:'' == $Lieferadresse->cOrt|default:''}
        {$beautekOpcSameShip = true}
    {/if}

    <div id="order-confirm" class="beautek-opc-step beautek-opc-confirm">
        {if !empty($smarty.get.mailBlocked)}
            {alert variant="danger"}{lang key='kwkEmailblocked' section='errorMessages'}{/alert}
        {/if}
        {if !empty($smarty.get.fillOut)}
            {alert variant="danger"}{lang key='mandatoryFieldNotification' section='errorMessages'}{/alert}
        {/if}

        <div class="beautek-opc-card beautek-opc-review">
            <div class="beautek-opc-review__row">
                <div class="beautek-opc-review__label">{lang key='shippingAdress' section='account data'}</div>
                <div class="beautek-opc-review__value">
                    {include file='checkout/inc_delivery_address.tpl'}
                </div>
                {link href="{get_static_route id='bestellvorgang.php'}?editLieferadresse=1"
                    class="beautek-opc-card__edit"}
                    {lang key='change'}
                {/link}
            </div>
            <div class="beautek-opc-review__row">
                <div class="beautek-opc-review__label">{lang key='billingAdress' section='account data'}</div>
                <div class="beautek-opc-review__value">
                    {if $beautekOpcSameShip}
                        <p class="beautek-opc-review__same">entspricht Lieferadresse</p>
                    {else}
                        {include file='checkout/inc_billing_address.tpl'}
                    {/if}
                </div>
                {link href="{get_static_route id='bestellvorgang.php'}?editRechnungsadresse=1"
                    class="beautek-opc-card__edit"}
                    {lang key='change'}
                {/link}
            </div>
            <div class="beautek-opc-review__row" id="shipping-method">
                <div class="beautek-opc-review__label">{lang key='shippingOptions'}</div>
                <div class="beautek-opc-review__value">
                    <p>{$smarty.session.Versandart->angezeigterName|transByISO}</p>
                    {$cEstimatedDelivery = JTL\Session\Frontend::getCart()->getEstimatedDeliveryTime()}
                    {if $cEstimatedDelivery|strlen > 0}
                        <p class="beautek-opc-review__meta">{$cEstimatedDelivery}</p>
                    {/if}
                </div>
                {link href="{get_static_route id='bestellvorgang.php'}?editVersandart=1"
                    class="beautek-opc-card__edit"}
                    {lang key='change'}
                {/link}
            </div>
            <div class="beautek-opc-review__row">
                <div class="beautek-opc-review__label">{lang key='paymentOptions'}</div>
                <div class="beautek-opc-review__value">
                    <p>{$smarty.session.Zahlungsart->angezeigterName|transByISO}</p>
                    {if isset($smarty.session.Zahlungsart->cHinweisText) && !empty($smarty.session.Zahlungsart->cHinweisText)}
                        <p class="beautek-opc-review__meta">{$smarty.session.Zahlungsart->cHinweisText}</p>
                    {/if}
                </div>
                {link href="{get_static_route id='bestellvorgang.php'}?editVersandart=1"
                    class="beautek-opc-card__edit"}
                    {lang key='change'}
                {/link}
            </div>
        </div>

        {if $GuthabenMoeglich}
            <div id="panel-edit-credit" class="beautek-opc-card">
                <div class="beautek-opc-card__head">
                    <span class="beautek-opc-card__title">{lang key='credit' section='account data'}</span>
                </div>
                <div class="beautek-opc-card__body">
                    {include file='checkout/credit_form.tpl'}
                </div>
            </div>
        {/if}

        {form method="post" name="agbform" id="complete_order" action="{get_static_route id='bestellabschluss.php'}" class="jtl-validate beautek-opc-final"}
            {lang key='agb' assign='agb'}
            {if !empty($AGB->cAGBContentHtml)}
                {modal id="agb-modal" title=$agb}{$AGB->cAGBContentHtml}{/modal}
            {elseif !empty($AGB->cAGBContentText)}
                {modal id="agb-modal" title=$agb}{$AGB->cAGBContentText}{/modal}
            {/if}
            {if $Einstellungen.kaufabwicklung.bestellvorgang_wrb_anzeigen == 1}
                {lang key='wrb' section='checkout' assign='wrb'}
                {lang key='wrbform' assign='wrbform'}
                {if !empty($AGB->cWRBContentHtml)}
                    {modal id="wrb-modal" title=$wrb}{$AGB->cWRBContentHtml}{/modal}
                {elseif !empty($AGB->cWRBContentText)}
                    {modal id="wrb-modal" title=$wrb}{$AGB->cWRBContentText}{/modal}
                {/if}
                {if !empty($AGB->cWRBFormContentHtml)}
                    {modal id="wrb-form-modal" title=$wrbform}{$AGB->cWRBFormContentHtml}{/modal}
                {elseif !empty($AGB->cWRBFormContentText)}
                    {modal id="wrb-form-modal" title=$wrbform}{$AGB->cWRBFormContentText}{/modal}
                {/if}
            {/if}

            {lang assign='orderCommentsTitle' key='orderComments' section='shipping payment'}
            <details class="beautek-opc-comment"{if isset($smarty.session.kommentar) && $smarty.session.kommentar|trim != ''} open{/if}>
                <summary>Kommentar <span>(optional)</span></summary>
                {textarea title=$orderCommentsTitle|escape:'html'
                    name="kommentar"
                    cols="50"
                    rows="3"
                    id="comment"
                    placeholder=$orderCommentsTitle|escape:'html'
                    aria=["label"=>$orderCommentsTitle|escape:'html']
                    class="checkout-confirmation-comment"}
                    {if isset($smarty.session.kommentar)}{$smarty.session.kommentar}{/if}
                {/textarea}
            </details>

            <div class="beautek-opc-legal checkout-confirmation-legal-notice">
                <p>{$AGB->agbWrbNotice}</p>
            </div>

            {if !isset($smarty.session.cPlausi_arr)}
                {assign var=plausiArr value=[]}
            {else}
                {assign var=plausiArr value=$smarty.session.cPlausi_arr}
            {/if}

            {hasCheckBoxForLocation bReturn="bCheckBox" nAnzeigeOrt=$nAnzeigeOrt cPlausi_arr=$plausiArr cPost_arr=$cPost_arr}
            {if $bCheckBox}
                <div class="beautek-opc-checkboxes">
                    {include file='snippets/checkbox.tpl' nAnzeigeOrt=$nAnzeigeOrt cPlausi_arr=$plausiArr cPost_arr=$cPost_arr}
                </div>
            {/if}

            {input type="hidden" name="abschluss" value="1"}
            {input type="hidden" id="comment-hidden" name="kommentar" value=""}

            <div id="panel-submit-order" class="beautek-opc-actions">
                <button type="submit"
                        name="abschluss"
                        value="1"
                        id="complete-order-button"
                        class="btn btn-primary btn-block submit_once beautek-opc-submit">
                    {lang key='orderLiableToPay' section='checkout'}
                </button>
                <a href="{get_static_route id='bestellvorgang.php'}?editVersandart=1" class="beautek-opc-backlink">Zurück</a>
            </div>
            {include file='checkout/inc_opc_trust.tpl'}
        {/form}
    </div>
{else}
    {include file="{$parent_template_path}/checkout/step5_confirmation.tpl"}
{/if}
