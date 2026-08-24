{include file='checkout/inc_opc_on.tpl'}
{if $beautekOpc}
    <div class="beautek-opc-step">
        {form id="form_payment_extra" class="form payment_extra" method="post" action="{get_static_route id='bestellvorgang.php'}" slide=true}
            <div class="beautek-opc-card">
                <div class="beautek-opc-card__head">
                    <span class="beautek-opc-card__title">{lang key='paymentOptions'}</span>
                </div>
                <div class="beautek-opc-card__body">
                    <div id="order-additional-payment" class="checkout-additional-payment form-group">
                        {include file=$Zahlungsart->cZusatzschrittTemplate}
                        {input type="hidden" name="zahlungsartwahl" value="1"}
                        {input type="hidden" name="zahlungsartzusatzschritt" value="1"}
                        {input type="hidden" name="Zahlungsart" value=$Zahlungsart->kZahlungsart}
                    </div>
                </div>
            </div>
            {include file='checkout/inc_opc_actions.tpl'
                opcPrimary='Weiter'
                opcBackHref="{get_static_route id='bestellvorgang.php'}?editVersandart=1"}
        {/form}
    </div>
{else}
    {include file="{$parent_template_path}/checkout/step4_payment_additional.tpl"}
{/if}
