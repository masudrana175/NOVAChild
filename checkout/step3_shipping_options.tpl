{include file='checkout/inc_opc_on.tpl'}
{if $beautekOpc}
    <div class="beautek-opc-step">
        {if !isset($Versandarten)}
            {alert variant="danger"}{lang key='noShippingMethodsAvailable' section='checkout'}{/alert}
        {else}
            {form method="post" action="{get_static_route id='bestellvorgang.php'}" class="form checkout-shipping-form jtl-validate"}
                <div class="beautek-opc-card">
                    <div class="beautek-opc-card__head">
                        <span class="beautek-opc-card__title">{lang key='shippingOptions'}</span>
                    </div>
                    <div class="beautek-opc-card__body">
                        <fieldset id="checkout-shipping-payment">
                            <div class="checkout-shipping-form-change">
                                {lang key='shippingTo' section='checkout'}: {$Lieferadresse->cStrasse} {$Lieferadresse->cHausnummer}, {$Lieferadresse->cPLZ} {$Lieferadresse->cOrt}, {$Lieferadresse->cLand}
                                {button href="{get_static_route id='bestellvorgang.php'}?editLieferadresse=1"
                                    variant="link"
                                    size="sm"
                                    class="font-size-sm"
                                }
                                    <span class="text-decoration-underline">{lang key='change'}</span>
                                    <span class="checkout-shipping-form-change-icon fa fa-pencil-alt"></span>
                                {/button}
                            </div>
                            <div class="checkout-shipping-form-options form-group">
                                {radiogroup stacked=true class='radio-w-100'}
                                    {foreach $Versandarten as $versandart}
                                        {radio
                                            name="Versandart"
                                            value=$versandart->kVersandart
                                            id="del{$versandart->kVersandart}"
                                            checked=($Versandarten|count == 1 || $AktiveVersandart == $versandart->kVersandart)
                                            required=($versandart@first)
                                            class="checkout-shipping-form-options-radio"
                                        }
                                            {formrow class="content"}
                                                {col cols=12 sm=5 class='title'}
                                                    {if $versandart->cBild}
                                                        {image fluid=true class="w-20" src=$versandart->cBild alt=$versandart->angezeigterName|transByISO}
                                                    {/if}
                                                    {if $versandart->angezeigterName|transByISO === '' && $versandart->cBild === ''}
                                                        {$versandart->cName}
                                                    {else}
                                                        {$versandart->angezeigterName|transByISO}
                                                    {/if}
                                                    {if !empty($versandart->angezeigterHinweistext|transByISO)}
                                                        <div>
                                                            <small>{$versandart->angezeigterHinweistext|transByISO}</small>
                                                        </div>
                                                    {/if}
                                                {/col}
                                                {col cols=12 sm=3}<small class="desc text-info">{$versandart->cLieferdauer|transByISO}</small>{/col}
                                                {col cols=12 sm=4 class='font-weight-bold-util price-col'}
                                                    {$versandart->cPreisLocalized}
                                                    {if !empty($versandart->Zuschlag->fZuschlag)}
                                                        <div>
                                                            <small>
                                                                ({$versandart->Zuschlag->angezeigterName|transById} +{$versandart->Zuschlag->cPreisLocalized})
                                                            </small>
                                                        </div>
                                                    {/if}
                                                {/col}
                                            {/formrow}
                                            <span class="checkout-shipping-form-options-specific-cost">
                                                {if isset($versandart->specificShippingcosts_arr)}
                                                    {foreach $versandart->specificShippingcosts_arr as $specificShippingcosts}
                                                        {row}
                                                            {col cols=8}
                                                                <ul>
                                                                    <li>
                                                                        <small>{$specificShippingcosts->cName|transByISO}</small>
                                                                    </li>
                                                                </ul>
                                                            {/col}
                                                            {col cols=4}
                                                                <small>{$specificShippingcosts->cPreisLocalized}</small>
                                                            {/col}
                                                        {/row}
                                                    {/foreach}
                                                {/if}
                                            </span>
                                        {/radio}
                                    {/foreach}
                                {/radiogroup}
                            </div>
                        </fieldset>
                    </div>
                </div>

                <div class="beautek-opc-card">
                    <div class="beautek-opc-card__head">
                        <span class="beautek-opc-card__title">{lang key='paymentOptions'}</span>
                    </div>
                    <div class="beautek-opc-card__body">
                        <fieldset id="fieldset-payment">
                            {$step4_payment_content}
                        </fieldset>
                    </div>
                </div>

                {if isset($Verpackungsarten) && $Verpackungsarten|@count > 0}
                    <div class="beautek-opc-card">
                        <div class="beautek-opc-card__head">
                            <span class="beautek-opc-card__title">{lang section='checkout' key='additionalPackaging'}</span>
                        </div>
                        <div class="beautek-opc-card__body">
                            <fieldset>
                                {checkboxgroup stacked=true}
                                {foreach $Verpackungsarten as $oVerpackung}
                                    <div class="checkout-shipping-form-packaging">
                                        {checkbox
                                            name="kVerpackung[]"
                                            value=$oVerpackung->kVerpackung
                                            id="pac{$oVerpackung->kVerpackung}"
                                            checked=(isset($oVerpackung->bWarenkorbAktiv) && $oVerpackung->bWarenkorbAktiv === true || (isset($AktiveVerpackung[$oVerpackung->kVerpackung]) && $AktiveVerpackung[$oVerpackung->kVerpackung] === 1))
                                        }
                                            <span class="checkout-shipping-form-packaging-title">
                                                {$oVerpackung->cName}
                                            </span>
                                            <span class="checkout-shipping-form-packaging-cost price-col">
                                                {if $oVerpackung->nKostenfrei == 1}
                                                    {lang key='ExemptFromCharges'}
                                                {elseif JTL\Session\Frontend::getCustomerGroup()->isMerchant()}
                                                    {$oVerpackung->fNettoLocalized}
                                                {else}
                                                    {$oVerpackung->fBruttoLocalized}
                                                {/if}
                                            </span>
                                            <span class="checkout-shipping-form-packaging-desc">
                                                <small>{$oVerpackung->cBeschreibung}</small>
                                            </span>
                                        {/checkbox}
                                    </div>
                                {/foreach}
                                {/checkboxgroup}
                            </fieldset>
                        </div>
                    </div>
                {/if}

                {if isset($Versandarten)}
                    {input type="hidden" name="versandartwahl" value="1"}
                    {input type="hidden" name="zahlungsartwahl" value="1"}
                    {include file='checkout/inc_opc_actions.tpl'
                        opcPrimary='Weiter'
                        opcBackHref="{get_static_route id='bestellvorgang.php'}?editRechnungsadresse=1"}
                {/if}
            {/form}
        {/if}
    </div>
    {if isset($smarty.get.editZahlungsart)}
        {inline_script}<script>
            $(document).ready(function () {
                $.evo.extended().smoothScrollToAnchor('#fieldset-payment');
            });
        </script>{/inline_script}
    {/if}
{else}
    {include file="{$parent_template_path}/checkout/step3_shipping_options.tpl"}
{/if}
