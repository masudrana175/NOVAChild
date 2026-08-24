{include file='checkout/inc_opc_on.tpl'}
{if $beautekOpc}
    {if !empty($fehlendeAngaben) && !$alertNote}
        {alert variant="danger"}{lang key='mandatoryFieldNotification' section='errorMessages'}{/alert}
    {/if}
    {if isset($fehlendeAngaben.email_vorhanden) && $fehlendeAngaben.email_vorhanden == 1}
        {alert variant="danger"}{lang key='emailAlreadyExists' section='account data'}{/alert}
    {/if}
    {if isset($fehlendeAngaben.formular_zeit) && $fehlendeAngaben.formular_zeit == 1}
        {alert variant="danger"}{lang key='formToFast' section='account data'}{/alert}
    {/if}

    <div id="register-customer" class="beautek-opc-step">
        <div id="existing-customer" class="beautek-opc-card checkout-existing-customer">
            <div class="beautek-opc-card__head">
                <span class="beautek-opc-card__title">{lang key='alreadyCustomer'}</span>
            </div>
            <div class="beautek-opc-card__body">
                {form method="post" action="{get_static_route id='bestellvorgang.php'}" class="jtl-validate" id="order_register_or_login" slide=true}
                    <fieldset>
                        {if $showTwoFAForm|default:false}
                            {include file='snippets/two_fa_login.tpl'}
                        {else}
                            {include file='register/form/customer_login.tpl'}
                        {/if}
                    </fieldset>
                {/form}
            </div>
        </div>

        <div class="beautek-opc-progress__sep-or" role="separator">{lang key='or'}</div>

        {form method="post" action="{get_static_route id='bestellvorgang.php'}" class="form checkout-register-form jtl-validate" id="form-register" slide=true}
            <div id="customer" class="beautek-opc-card">
                <div class="beautek-opc-card__head">
                    <span class="beautek-opc-card__title">{lang key='billingAdress' section='account data'}</span>
                </div>
                <div class="beautek-opc-card__body">
                    {include file='register/form/customer_account.tpl' checkout=1 step="formular"}
                    {include file='checkout/inc_shipping_address.tpl'}
                    {if isset($oSpezialseiten_arr[$smarty.const.LINKTYP_DATENSCHUTZ])}
                        <p class="checkout-register-form-buttons-privacy beautek-opc-legal">
                            {link href=$oSpezialseiten_arr[$smarty.const.LINKTYP_DATENSCHUTZ]->getURL() class="popup"}
                                {lang key='privacyNotice'}
                            {/link}
                        </p>
                    {/if}
                    {input type="hidden" name="checkout" value="1"}
                    {input type="hidden" name="form" value="1"}
                    {input type="hidden" name="editRechnungsadresse" value="0"}
                </div>
            </div>
            {include file='checkout/inc_opc_actions.tpl'
                opcPrimary='Weiter'
                opcBackHref="{get_static_route id='warenkorb.php'}"
                opcBackLabel='Zurück'}
        {/form}
    </div>
{else}
    {include file="{$parent_template_path}/checkout/step0_login_or_register.tpl"}
{/if}
