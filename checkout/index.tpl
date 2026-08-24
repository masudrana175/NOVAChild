{extends file="{$parent_template_path}/checkout/index.tpl"}

{block name='checkout-index-content'}
    {include file='checkout/inc_opc_flag.tpl' beautekOpcEmitCookie=false beautekOpcShowBanner=false}
    {include file='checkout/inc_opc_on.tpl'}
    {if $beautekOpc}
        <div id="result-wrapper" data-wrapper="true">
            {container fluid=true id="checkout"}
                <div class="beautek-opc">
                    {include file='checkout/inc_opc_flag.tpl' beautekOpcEmitCookie=false beautekOpcShowBanner=true}
                    <div class="beautek-opc__grid">
                        <div class="beautek-opc__main">
                            {include file='checkout/inc_steps.tpl' beautekOpc=true}
                            {if $step === 'accountwahl'}
                                {include file='checkout/step0_login_or_register.tpl' beautekOpc=true}
                            {elseif $step === 'edit_customer_address' || $step === 'Lieferadresse'}
                                {include file='checkout/step1_edit_customer_address.tpl' beautekOpc=true}
                            {elseif $step === 'Versand' || $step === 'Zahlung'}
                                {include file='checkout/step3_shipping_options.tpl' beautekOpc=true}
                            {elseif $step === 'ZahlungZusatzschritt'}
                                {include file='checkout/step4_payment_additional.tpl' beautekOpc=true}
                            {elseif $step === 'Bestaetigung'}
                                {include file='checkout/step5_confirmation.tpl' beautekOpc=true}
                            {/if}
                        </div>
                        {$beautekOpcShowCoupon = false}
                        {$beautekOpcShowOrderButton = false}
                        {if $step === 'Versand' || $step === 'Zahlung' || $step === 'ZahlungZusatzschritt' || $step === 'Bestaetigung'}
                            {$beautekOpcShowCoupon = true}
                        {/if}
                        {if $step === 'Bestaetigung'}
                            {$beautekOpcShowOrderButton = true}
                        {/if}
                        {include file='checkout/inc_opc_summary.tpl'
                            beautekOpc=true
                            beautekOpcShowCoupon=$beautekOpcShowCoupon
                            beautekOpcShowOrderButton=$beautekOpcShowOrderButton}
                    </div>
                </div>
            {/container}
            {block name='checkout-index-script-location'}
                <script>
                    if (top.location !== self.location) {
                        top.location = self.location.href;
                    }
                </script>
            {/block}
        </div>

        {if (isset($nWarenkorb2PersMerge) && $nWarenkorb2PersMerge === 1)}
            {block name='checkout-index-script-basket-merge'}
                {inline_script}<script>
                    $(window).on('load', function() {
                        $(function() {
                            eModal.addLabel('{lang key='yes' section='global' addslashes=true}', '{lang key='no' section='global' addslashes=true}');
                            var options = {
                                message: '{lang key='basket2PersMerge' section='login' addslashes=true}',
                                label: '{lang key='yes' section='global' addslashes=true}',
                                title: '{lang key='basket' section='global' addslashes=true}'
                            };
                            eModal.confirm(options).then(
                                function() {
                                    window.location = "{get_static_route id='bestellvorgang.php'}?basket2Pers=1&token={$smarty.session.jtl_token}"
                                },
                                function() {
                                    window.location = "{get_static_route id='bestellvorgang.php'}?updatePersCart=1&token={$smarty.session.jtl_token}"
                                }
                            );
                        });
                    });
                </script>{/inline_script}
            {/block}
        {/if}
    {else}
        {$smarty.block.parent}
    {/if}
{/block}
