{include file='checkout/inc_opc_on.tpl'}
{if $beautekOpc && isset($smarty.get.fromCheckout)}
    {if !isset($isModal)}
        {assign var=isModal value=false}
    {/if}
    <div class="beautek-opc">
        <div class="beautek-opc__grid">
            <div class="beautek-opc__main">
                {if isset($bestellschritt)}
                    {include file='checkout/inc_steps.tpl' beautekOpc=true}
                {else}
                    <nav class="beautek-opc-progress" aria-label="{lang key='secureCheckout' section='checkout'}">
                        <span class="beautek-opc-progress__item is-current">
                            <span class="beautek-opc-progress__num">1</span>
                            <span class="beautek-opc-progress__label">Adresse</span>
                        </span>
                        <span class="beautek-opc-progress__sep" aria-hidden="true"></span>
                        {link href="{get_static_route id='bestellvorgang.php'}?editVersandart=1"
                            class="beautek-opc-progress__item"}
                            <span class="beautek-opc-progress__num">2</span>
                            <span class="beautek-opc-progress__label">Zahlung</span>
                        {/link}
                        <span class="beautek-opc-progress__sep" aria-hidden="true"></span>
                        <span class="beautek-opc-progress__item">
                            <span class="beautek-opc-progress__num">3</span>
                            <span class="beautek-opc-progress__label">Bestellen</span>
                        </span>
                    </nav>
                {/if}
                <div class="beautek-opc-step">
                    {form method="post" id='lieferadressen' action="{get_static_route params=['editLieferadresse' => 1]}" class="jtl-validate" slide=true}
					<div class="required-info">{lang key='requiredInfo'}</div>
                        <div class="beautek-opc-card">
                            <div class="beautek-opc-card__head">
                                <span class="beautek-opc-card__title">{lang key='shippingAdress' section='account data'}</span>
                            </div>
                            <div class="beautek-opc-card__body">
                                <div class="required-info">{lang key='requiredInfo'}</div>
                                {include file='checkout/customer_shipping_address.tpl' prefix="register" fehlendeAngaben=null}
                                {include file='checkout/customer_shipping_contact.tpl' prefix="register" fehlendeAngaben=null}
                                {input type="hidden" name="editLieferadresse" value="1"}
                                {if isset($Lieferadresse->nIstStandardLieferadresse) && $Lieferadresse->nIstStandardLieferadresse === 1}
                                    {input type="hidden" name="isDefault" value=1}
                                {/if}
                                {if isset($Lieferadresse->kLieferadresse)}
                                    {input type="hidden" name="updateAddress" value=$Lieferadresse->kLieferadresse}
                                    {input type="hidden" name="backToCheckout" value="1"}
                                {else}
                                    {input type="hidden" name="editAddress" value="neu"}
                                    {input type="hidden" name="backToCheckout" value="1"}
                                {/if}
                            </div>
                        </div>
                        {include file='checkout/inc_opc_actions.tpl'
                            opcPrimary='Weiter'
                            opcBackHref="{get_static_route id='bestellvorgang.php'}?editVersandart=1"}
                    {/form}
                </div>
            </div>
            {if isset($WarensummeLocalized)}
                {include file='checkout/inc_opc_summary.tpl' beautekOpc=true beautekOpcShowCoupon=false}
            {/if}
        </div>
    </div>
{else}
    {include file="{$parent_template_path}/account/shipping_address_form.tpl"}
{/if}
