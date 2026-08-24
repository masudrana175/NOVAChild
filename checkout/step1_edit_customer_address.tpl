{include file='checkout/inc_opc_on.tpl'}
{if $beautekOpc}
    {if isset($editRechnungsadresse) && $editRechnungsadresse === 1 && JTL\Session\Frontend::getCustomer()->getID() > 0}
        {assign var=unreg_form value=0}
        {assign var=unreg_step value=$step}
    {else}
        {assign var=unreg_form value=1}
        {assign var=unreg_step value='formular'}
    {/if}
    {$beautekOpcShipEdit = ($step === 'Lieferadresse' || isset($smarty.get.editLieferadresse))}
    {if !empty($fehlendeAngaben) && !$alertNote}
        {alert variant="danger"}{lang key='mandatoryFieldNotification' section='errorMessages'}{/alert}
    {/if}

    <div id="order-proceed-as-guest" class="beautek-opc-step">
        {form id="neukunde" method="post" action="{get_static_route id='bestellvorgang.php'}" class="jtl-validate" slide=true}
            <div class="beautek-opc-card">
                <div class="beautek-opc-card__head">
                    <span class="beautek-opc-card__title">
                        {if $beautekOpcShipEdit}
                            {lang key='shippingAdress' section='account data'}
                        {else}
                            {lang section='account data' key='billingAndDeliveryAddress'}
                        {/if}
                    </span>
                </div>
                <div class="beautek-opc-card__body">
                    {if $beautekOpcShipEdit}
                        {include file='checkout/inc_opc_billing_hidden.tpl'}
                        {input type="hidden" name="shipping_address" value="1"}
                        {if isset($kLieferadresse) && $kLieferadresse > 0}
                            {input type="hidden" name="kLieferadresse" value=$kLieferadresse}
                        {else}
                            {input type="hidden" name="kLieferadresse" value="-1"}
                        {/if}
                        {assign var=fehlendeAngabenShipping value=$fehlendeAngaben.shippingAddress|default:null}
                        {include file='checkout/customer_shipping_address.tpl' prefix="register" fehlendeAngaben=$fehlendeAngabenShipping}
                        {include file='checkout/customer_shipping_contact.tpl' prefix="register" fehlendeAngaben=$fehlendeAngabenShipping}
                    {else}
                        {include file='checkout/inc_billing_address_form.tpl' step=$unreg_step}
                        {include file='checkout/inc_shipping_address.tpl'}
                    {/if}
                    {input type="hidden" name="unreg_form" value=$unreg_form}
                    {input type="hidden" name="editRechnungsadresse" value=$editRechnungsadresse}
                </div>
            </div>
            {if $beautekOpcShipEdit}
                {include file='checkout/inc_opc_actions.tpl'
                    opcPrimary='Weiter'
                    opcBackHref="{get_static_route id='bestellvorgang.php'}?editVersandart=1"}
            {elseif isset($editRechnungsadresse) && $editRechnungsadresse == 1}
                {include file='checkout/inc_opc_actions.tpl'
                    opcPrimary='Weiter'
                    opcBackHref="{get_static_route id='bestellvorgang.php'}"}
            {else}
                {include file='checkout/inc_opc_actions.tpl'
                    opcPrimary='Weiter'
                    opcBackHref="{get_static_route id='warenkorb.php'}"}
            {/if}
        {/form}
    </div>
{else}
    {include file="{$parent_template_path}/checkout/step1_edit_customer_address.tpl"}
{/if}
