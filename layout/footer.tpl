{extends file="{$parent_template_path}/layout/footer.tpl"}

{if $smarty.server.REMOTE_ADDR == '80.187.74.150' || '130.180.64.137' || $smarty.server.REMOTE_ADDR == '93.227.204.108' || $smarty.server.REMOTE_ADDR == '46.82.90.215' || $smarty.server.REMOTE_ADDR == '91.54.45.177'}
{block name='layout-footer-content' }

    {if !$bExclusive}
        {assign var='newsletterActive' value=($Einstellungen.template.footer.newsletter_footer === 'Y' && $Einstellungen.newsletter.newsletter_active === 'Y')}
        
        <footer id="footer" class="cstm-footer {if $newsletterActive}newsletter-active{/if}">

            <div class="container-fluid container-fluid-xl d-print-none">


            {block name='layout-footer-boxes'}
                {getBoxesByPosition position='bottom' assign='footerBoxes'}
                {if isset($footerBoxes) && count($footerBoxes) > 0}

                        {row class="boxes-custom" id='footer-boxes'}

                        {col cols=12 sm=6 md=3}

                            {block name='layout-footer-newsletter-heading'}
                                <div class="h2 newsletter-footer-heading">
                                    {lang key='newsletterHeading' section='custom'}
                                </div>
                            {/block}

                            {block name="custom-newsletter"}
                                <!-- Begin Brevo Form -->
                                <!-- START - We recommend to place the below code in head tag of your website html  -->
                             

                                <link rel="stylesheet" href="https://sibforms.com/forms/end-form/build/sib-styles.css">
                                <!--  END - We recommend to place the above code in head tag of your website html -->

                                <!-- START - We recommend to place the below code where you want the form in your website html  -->
                                <div class="sib-form" style="text-align: center;
                                        background-color: transparent; padding: 0px;">
                                <div id="sib-form-container" class="sib-form-container">
                                    <div id="error-message" class="sib-form-message-panel" style="display:none;font-size:16px; text-align:left;  color:#661d1d; background-color:#ffeded; border-radius:3px; border-color:#ff4949;max-width:540px;">
                                    <div class="sib-form-message-panel__text sib-form-message-panel__text--center">
                                        <svg viewBox="0 0 512 512" class="sib-icon sib-notification__icon" width="24" height="24" style="width:24px;height:24px;max-width:24px;max-height:24px;">
                                        <path d="M256 40c118.621 0 216 96.075 216 216 0 119.291-96.61 216-216 216-119.244 0-216-96.562-216-216 0-119.203 96.602-216 216-216m0-32C119.043 8 8 119.083 8 256c0 136.997 111.043 248 248 248s248-111.003 248-248C504 119.083 392.957 8 256 8zm-11.49 120h22.979c6.823 0 12.274 5.682 11.99 12.5l-7 168c-.268 6.428-5.556 11.5-11.99 11.5h-8.979c-6.433 0-11.722-5.073-11.99-11.5l-7-168c-.283-6.818 5.167-12.5 11.99-12.5zM256 340c-15.464 0-28 12.536-28 28s12.536 28 28 28 28-12.536 28-28-12.536-28-28-28z" />
                                        </svg>
                                        <span class="sib-form-message-panel__inner-text">
                                                        Ihre Anmeldung konnte nicht gespeichert werden. Bitte versuchen Sie es erneut.
                                                    </span>
                                    </div>
                                    </div>
                                    <div></div>
                                    <div id="success-message" class="sib-form-message-panel" style="display:none;font-size:16px; text-align:left;  color:#085229; background-color:#e7faf0; border-radius:3px; border-color:#13ce66;max-width:540px;">
                                    <div class="sib-form-message-panel__text sib-form-message-panel__text--center">
                                        <svg viewBox="0 0 512 512" class="sib-icon sib-notification__icon" width="24" height="24" style="width:24px;height:24px;max-width:24px;max-height:24px;">
                                        <path d="M256 8C119.033 8 8 119.033 8 256s111.033 248 248 248 248-111.033 248-248S392.967 8 256 8zm0 464c-118.664 0-216-96.055-216-216 0-118.663 96.055-216 216-216 118.664 0 216 96.055 216 216 0 118.663-96.055 216-216 216zm141.63-274.961L217.15 376.071c-4.705 4.667-12.303 4.637-16.97-.068l-85.878-86.572c-4.667-4.705-4.637-12.303.068-16.97l8.52-8.451c4.705-4.667 12.303-4.637 16.97.068l68.976 69.533 163.441-162.13c4.705-4.667 12.303-4.637 16.97.068l8.451 8.52c4.668 4.705 4.637 12.303-.068 16.97z" />
                                        </svg>
                                        <span class="sib-form-message-panel__inner-text">
                                                        Ihre Anmeldung war erfolgreich.
                                                    </span>
                                    </div>
                                    </div>
                                    <div></div>
                                    <div id="sib-container" class="sib-container--large sib-container--vertical" style="padding: 0; text-align:center; background-color:transparent; max-width:540px; border-radius:3px; border-width:0px; border-color:#ffffff; border-style:solid; direction:ltr">
                                    <form id="sib-form" method="POST" action="https://0713ccd4.sibforms.com/serve/MUIFACkkApo4ORAqRDFG2YpRgeMenpOHdUyYRWBagi1BhYJhL8OmHdCsj2nG9GkFOWyIIzKIRD5EiY4NYkSSIg64oJsbDq9lW35eK0j95fAPZaIR9XQ7qzjlyxJvqV1UwW3j8JA-CNpsaYBH695l27Me8oiIwuMIfagkaOe6tqROODhcD505DjGsHLMtUs1FzYzpbihWizbqNzFm" data-type="subscription">
                                        <div style="padding: 8px 0;">
                                        <div class="sib-input sib-form-block">
                                            <div class="form__entry entry_block">
                                            <div class="form__label-row ">

                                                <div class="entry__field" style="margin: 0px;">
                                                <input class="input " placeholder="Vorname eingeben" type="text" id="VORNAME" name="VORNAME" autocomplete="off" data-required="true" required />
                                                </div>
                                            </div>

                                            <label class="entry__error entry__error--primary" style="font-size:16px; text-align:left;  color:#661d1d; background-color:#ffeded; border-radius:3px; border-color:#ff4949;">
                                            </label>
                                            </div>
                                        </div>
                                        </div>
                                        <div style="padding: 8px 0;">
                                        <div class="sib-input sib-form-block">
                                            <div class="form__entry entry_block">
                                            <div class="form__label-row ">

                                                <div class="entry__field" style="margin: 0px;">
                                                <input class="input " placeholder="E-Mail Adresse eingeben" type="text" id="EMAIL" name="EMAIL" autocomplete="off" data-required="true" required />
                                                </div>
                                            </div>

                                            <label class="entry__error entry__error--primary" style="font-size:16px; text-align:left;  color:#661d1d; background-color:#ffeded; border-radius:3px; border-color:#ff4949;">
                                            </label>
                                            </div>

                                        <button class="sib-form-block__button sib-form-block__button-with-loader" style="font-size:16px; text-align:center; font-weight:700; font-family:&quot;Futura&quot;, sans-serif; color:#060606; background-color:#ffffff; border-radius:1px; border-width:0px;" form="sib-form" type="submit">
                                            <svg version="1.1" id="arrow" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 512.002 512.002" style="enable-background:new 0 0 512.002 512.002;" xml:space="preserve">
                                                <g>
                                                    <g>
                                                        <path d="M388.425,241.951L151.609,5.79c-7.759-7.733-20.321-7.72-28.067,0.04c-7.74,7.759-7.72,20.328,0.04,28.067l222.72,222.105
                                                            L123.574,478.106c-7.759,7.74-7.779,20.301-0.04,28.061c3.883,3.89,8.97,5.835,14.057,5.835c5.074,0,10.141-1.932,14.017-5.795
                                                            l236.817-236.155c3.737-3.718,5.834-8.778,5.834-14.05S392.156,245.676,388.425,241.951z"></path>
                                                    </g>
                                                </g>
                                            </svg>
                                        </button>

                                        </div>
                                        </div>
                                        <div style="padding: 8px 0;">
                                        <div class="sib-optin sib-form-block" data-required="true">
                                            <div class="form__entry entry_mcq">
                                            <div class="form__label-row ">
                                                <div class="entry__choice" style="">
                                                <label>
                                                    <input type="checkbox" class="input_replaced" value="1" id="OPT_IN" name="OPT_IN" required />
                                                    <span class="checkbox checkbox_tick_positive"
                                            style="margin-left:"
                                            ></span><span><p>Ich möchte den BEAUTEK Newsletter erhalten und akzeptiere die Datenschutzerklärung.</p><span data-required="*" style="display: inline;" class="entry__label entry__label_optin"></span></span> </label>
                                                </div>
                                            </div>
                                            <label class="entry__error entry__error--primary" style="font-size:16px; text-align:left;  color:#661d1d; background-color:#ffeded; border-radius:3px; border-color:#ff4949;">
                                            </label>
                                            <label class="entry__specification">
                                                <div class="newsletter-note">{lang key="footerNewsletterNote" section="custom"}</div>
                                            </label>
                                            </div>
                                        </div>
                                        </div>


                                        <input type="text" name="email_address_check" value="" class="input--hidden">
                                        <input type="hidden" name="locale" value="de">
                                    </form>
                                    </div>
                                    
                                    <!-- Newsletter Danke-Popup -->
                                    <div id="newsletter-popup" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.7); z-index:9999; justify-content:center; align-items:center;">
                                        <div style="background:#fff; padding:40px; border-radius:8px; max-width:400px; text-align:center; position:relative;">
                                            <button id="close-popup" style="position:absolute; top:10px; right:15px; border:none; background:none; font-size:24px; cursor:pointer;">&times;</button>
                                            <h3 style="color:#333; margin-bottom:15px;">Vielen Dank für deine Anmeldung!</h3>
                                            <p style="color:#666;">Du erhältst in Kürze eine Bestätigungs-E-Mail. Bitte bestätige deine Anmeldung, um den Newsletter zu erhalten.</p>
                                        </div>
                                    </div>
                                    
                                    <script>
                                    (function () {
                                        var form = document.getElementById('sib-form');
                                        var popup = document.getElementById('newsletter-popup');
                                        var closeBtn = document.getElementById('close-popup');
                                        if (!form || !popup) return;

                                        form.addEventListener('submit', function (e) {
                                            e.preventDefault();
                                            var formData = new FormData(form);
                                            var showThanks = function () {
                                                popup.style.display = 'flex';
                                                form.reset();
                                            };
                                            try {
                                                fetch(form.action, {
                                                    method: 'POST',
                                                    body: formData,
                                                    mode: 'no-cors'
                                                }).then(showThanks).catch(showThanks);
                                            } catch (err) {
                                                showThanks();
                                            }
                                        });

                                        if (closeBtn) {
                                            closeBtn.addEventListener('click', function () {
                                                popup.style.display = 'none';
                                            });
                                        }
                                        popup.addEventListener('click', function (e) {
                                            if (e.target === popup) popup.style.display = 'none';
                                        });
                                    })();
                                    </script>
                                </div>
                                </div>
                                <!-- END - We recommend to place the above code where you want the form in your website html  -->
                                <!-- END - We recommend to place the above code in footer or bottom of your website html  -->
                                <!-- End Brevo Form -->
                            {/block}

                            {block name="socials"}
                                       <ul class="list-unstyled socials">
                                    {if !empty($Einstellungen.template.footer.facebook)}
                                        <li>
                                            {link href="{if $Einstellungen.template.footer.facebook|strpos:'http' !== 0}https://{/if}{$Einstellungen.template.footer.facebook}"
                                            class="btn-icon-beautek btn-facebook btn btn-sm" aria=['label'=>"{lang key='visit_us_on' section='aria' printf='Facebook'}"] title="Facebook" target="_blank" rel="noopener"}
                                            {literal}

                                                <svg width="31" height="31" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
                                                    viewBox="0 0 141.7 141.7" style="enable-background:new 0 0 141.7 141.7;" xml:space="preserve">
                                                <style type="text/css">
                                                    .st0{fill-rule:evenodd;clip-rule:evenodd;fill:#FFFFFF;}
                                                </style>
                                                <path class="st0" d="M101,18.6H40.7c-10,0-18.1,8.1-18.1,18.1l0,0V97c0,10,8.1,18.1,18.1,18.1l0,0H101c10,0,18.1-8.1,18.1-18.1l0,0
                                                    V36.7C119.1,26.7,111,18.6,101,18.6L101,18.6z M98.6,70.6h-9V104H74.5V70.6h-5.9V59.4h5.9v-7.2c0-9.4,3.9-15,15-15h11.2v11.2h-6.5
                                                    c-4.3,0-4.6,1.6-4.6,4.6v6.3h10.3L98.6,70.6L98.6,70.6z"/>
                                                </svg>
                                                
                                            {/literal}
                                            {/link}
                                        </li>
                                    {/if}
                                    {if !empty($Einstellungen.template.footer.twitter)}
                                        <li>
                                            {link href="{if $Einstellungen.template.footer.twitter|strpos:'http' !== 0}https://{/if}{$Einstellungen.template.footer.twitter}"
                                            class="btn-icon-beautek btn-twitter btn btn-sm" aria=['label'=>"{lang key='visit_us_on' section='aria' printf='Twitter'}"] title="Twitter" target="_blank" rel="noopener"}
                                                <i class="fab fa-twitter fa-fw fa-lg"></i>
                                            {/link}
                                        </li>
                                    {/if}
                                    {if !empty($Einstellungen.template.footer.youtube)}
                                        <li>
                                            {link href="{if $Einstellungen.template.footer.youtube|strpos:'http' !== 0}https://{/if}{$Einstellungen.template.footer.youtube}"
                                            class="btn-icon-beautek btn-youtube btn btn-sm" aria=['label'=>"{lang key='visit_us_on' section='aria' printf='YouTube'}"] title="YouTube" target="_blank" rel="noopener"}
                                                <i class="fab fa-youtube fa-fw fa-lg"></i>
                                            {/link}
                                        </li>
                                    {/if}
                                    {if !empty($Einstellungen.template.footer.vimeo)}
                                        <li>
                                            {link href="{if $Einstellungen.template.footer.vimeo|strpos:'http' !== 0}https://{/if}{$Einstellungen.template.footer.vimeo}"
                                            class="btn-icon-beautek btn-vimeo btn btn-sm" aria=['label'=>"{lang key='visit_us_on' section='aria' printf='Vimeo'}"]  title="Vimeo" target="_blank" rel="noopener"}
                                                <i class="fab fa-vimeo-v fa-fw fa-lg"></i>
                                            {/link}
                                        </li>
                                    {/if}
                                    {if !empty($Einstellungen.template.footer.instagram)}
                                        <li>
                                            {link href="{if $Einstellungen.template.footer.instagram|strpos:'http' !== 0}https://{/if}{$Einstellungen.template.footer.instagram}"
                                            class="btn-icon-beautek btn-instagram btn btn-sm" aria=['label'=>"{lang key='visit_us_on' section='aria' printf='Instagram'}"]  title="Instagram" target="_blank" rel="noopener"}
                                                <svg width="29" height="29" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
                                                    viewBox="0 0 141.7 141.7" style="enable-background:new 0 0 141.7 141.7;" xml:space="preserve">
                                                <path fill="#ffffff" class="st0" d="M53.4,71.5c0-10,8.1-18.2,18.1-18.2c10,0,18.2,8.1,18.2,18.1c0,10-8.1,18.2-18.1,18.2c0,0,0,0,0,0
                                                    C61.5,89.6,53.4,81.5,53.4,71.5C53.4,71.4,53.4,71.4,53.4,71.5 M43.5,71.4c0,15.5,12.5,28,28,28s28-12.5,28-28c0-15.5-12.5-28-28-28
                                                    h0C56.1,43.5,43.5,56,43.5,71.4 M94.1,42.4c0,3.6,2.9,6.5,6.5,6.5c3.6,0,6.5-2.9,6.5-6.5c0-3.6-2.9-6.5-6.5-6.5l0,0l0,0
                                                    C97,35.8,94.1,38.7,94.1,42.4 M49.5,115.8c-3.5,0-6.9-0.7-10.1-1.9c-2.4-0.9-4.5-2.3-6.3-4.1c-1.8-1.8-3.2-3.9-4.1-6.3
                                                    c-1.2-3.2-1.8-6.7-1.9-10.1c-0.3-5.7-0.3-7.5-0.3-22.1s0-16.3,0.3-22.1c0-3.5,0.7-6.9,1.9-10.1c0.9-2.4,2.3-4.5,4.1-6.3
                                                    c1.8-1.8,3.9-3.2,6.3-4.1c3.2-1.2,6.7-1.8,10.1-1.9c5.8-0.3,7.5-0.3,22.1-0.3s16.3,0,22.1,0.3c3.5,0,6.9,0.7,10.1,1.9
                                                    c2.4,0.9,4.5,2.3,6.3,4.1c1.8,1.8,3.2,3.9,4.1,6.3c1.2,3.2,1.8,6.7,1.9,10.1c0.3,5.8,0.3,7.5,0.3,22.1s0,16.3-0.3,22.1
                                                    c0,3.5-0.7,6.9-1.9,10.1c-0.9,2.4-2.2,4.5-4.1,6.3c-1.8,1.8-3.9,3.2-6.3,4.1c-3.2,1.2-6.7,1.8-10.1,1.9c-5.8,0.3-7.5,0.3-22.1,0.3
                                                    S55.3,116.1,49.5,115.8 M49,17.3c-4.5,0.1-9,0.9-13.2,2.5c-7.3,2.8-13.1,8.6-15.9,15.9c-1.6,4.2-2.4,8.7-2.5,13.2
                                                    c-0.3,5.8-0.3,7.7-0.3,22.5s0,16.7,0.3,22.5c0.1,4.5,0.9,9,2.5,13.2c2.8,7.3,8.6,13.1,15.9,16c4.2,1.6,8.7,2.4,13.2,2.5
                                                    c5.8,0.3,7.7,0.3,22.5,0.3s16.7,0,22.5-0.3c4.5-0.1,9-0.9,13.2-2.5c7.3-2.8,13.1-8.6,15.9-15.9c1.6-4.2,2.4-8.7,2.5-13.2
                                                    c0.3-5.8,0.3-7.7,0.3-22.5s0-16.7-0.3-22.5c-0.1-4.5-0.9-9-2.5-13.2c-2.8-7.3-8.6-13.1-15.9-15.9c-4.2-1.6-8.7-2.5-13.2-2.5
                                                    c-5.8-0.3-7.7-0.3-22.5-0.3S54.8,17,49,17.3"/>
                                                </svg>
                                            {/link}
                                        </li>
                                    {/if}
                                    {if !empty($Einstellungen.template.footer.skype)}
                                        <li>
                                            {link href="{if $Einstellungen.template.footer.skype|strpos:'http' !== 0}https://{/if}{$Einstellungen.template.footer.skype}"
                                            class="btn-icon-beautek btn-skype btn btn-sm" aria=['label'=>"{lang key='visit_us_on' section='aria' printf='Skype'}"]  title="Skype" target="_blank" rel="noopener"}
                                                <i class="fab fa-skype fa-fw fa-lg"></i>
                                            {/link}
                                        </li>
                                    {/if}
                                    {if !empty($Einstellungen.template.footer.xing)}
                                        <li>
                                            {link href="{if $Einstellungen.template.footer.xing|strpos:'http' !== 0}https://{/if}{$Einstellungen.template.footer.xing}"
                                            class="btn-icon-beautek btn-xing btn btn-sm" aria=['label'=>"{lang key='visit_us_on' section='aria' printf='Xing'}"]  title="Xing" target="_blank" rel="noopener"}
                                                <i class="fab fa-xing fa-fw fa-lg"></i>
                                            {/link}
                                        </li>
                                    {/if}
                                    {if !empty($Einstellungen.template.footer.linkedin)}
                                        <li>
                                            {link href="{if $Einstellungen.template.footer.linkedin|strpos:'http' !== 0}https://{/if}{$Einstellungen.template.footer.linkedin}"
                                            class="btn-icon-beautek btn-linkedin btn btn-sm" aria=['label'=>"{lang key='visit_us_on' section='aria' printf='Linkedin'}"]  title="Linkedin" target="_blank" rel="noopener"}
                                                <svg width="28" height="28" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 141.7 141.7" style="enable-background:new 0 0 141.7 141.7;" xml:space="preserve">
                                                <path fill="#ffffff" class="st0" d="M115.6,18.3H26.1c-4.2-0.1-7.7,3.3-7.8,7.5v90c0.1,4.2,3.5,7.6,7.8,7.5h89.5c4.2,0.1,7.7-3.3,7.8-7.5
                                                    c0,0,0,0,0,0v-90C123.3,21.6,119.9,18.3,115.6,18.3C115.6,18.3,115.6,18.3,115.6,18.3z M34.6,106.3V59h15.7v47.3H34.6z M42.4,52.4
                                                    h-0.1c-4.5,0.3-8.4-3.1-8.7-7.6c0-0.2,0-0.4,0-0.6c0-4.6,3.5-8.2,8.9-8.2c4.5-0.3,8.4,3,8.8,7.5c0,0.2,0,0.4,0,0.6
                                                    C51.3,48.9,47.9,52.5,42.4,52.4L42.4,52.4z M106.9,106.3H91.3V81c0-6.4-2.3-10.7-8-10.7c-3.6,0-6.9,2.3-8.1,5.8
                                                    c-0.4,1.2-0.6,2.5-0.5,3.8v26.4H59c0,0,0.2-42.9,0-47.3h15.7v6.7c2.9-5,8.3-8.1,14.2-7.8c10.3,0,18.1,6.7,18.1,21.3L106.9,106.3z"/>
                                                </svg>
                                            {/link}
                                        </li>
                                    {/if}
                                    {if !empty($Einstellungen.template.footer.pinterest)}
                                        <li>
                                            {link href="{if $Einstellungen.template.footer.pinterest|strpos:'http' !== 0}https://{/if}{$Einstellungen.template.footer.pinterest}"
                                            class="btn-icon-beautek btn-pinterest btn btn-sm" aria=['label'=>"{lang key='visit_us_on' section='aria' printf='Pinterest'}"]  title="Pinterest" target="_blank" rel="noopener"}
                                                <svg width="30" height="30" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" x="0px" y="0px" viewBox="0 0 141.7 141.7" style="enable-background:new 0 0 141.7 141.7;" xml:space="preserve">
                                                <path fill="#ffffff" d="M70.9,17C41.1,17,17,41.1,17,70.8c0,21.9,13.2,41.6,33.5,49.8c-2.3-17.6,4.1-30.8,7.2-45  c-5.2-8.4,0.6-25.2,11.7-21.1c13.6,5.1-11.8,31.2,5.2,34.5c17.7,3.4,25-29.4,14-40C72.6,33.6,42.3,48.6,46,70.6c0.5,2.7,5,7,5,7  c-0.3,2.5-0.8,5-1.4,7.4c-10.2-2.1-14.5-9.8-14.1-20c0.6-16.7,15.8-28.4,30.9-30C85.5,33,103.5,41.8,106,59  c2.8,19.4-8.6,40.4-29.2,38.9c-5.6-0.4-7.9-3-12.2-5.6c-2.3,11.5-5.1,22.6-13.1,28.8c27.7,10.7,58.9-3.1,69.6-30.8  c10.7-27.7-3.1-58.9-30.8-69.6C84.1,18.3,77.5,17,70.9,17L70.9,17z"/>
                                                </svg>
                                            {/link}
                                        </li>
                                    {/if}
                                </ul>
                            {/block}

                        {/col}

                        {col cols=12 sm=1 lg=1}
                        {/col}

                    {foreach $footerBoxes as $box}
                        {if $box->title[1] == "Gesetzliche Informationen"}
                        {else}
                            {col cols=12 sm=6 md=4 lg=2}
                            {$box->getRenderedContent()}
                            {/col}
                        {/if}
                    {/foreach}
                    {/row}

                {/if}
            {/block}

            </div>
            
            <div class="footer-payment-row"></div>

            <div class="footer-bottom-background-switch">

                {container class="d-print-none container-fluid-xl" fluid=true}
                {block name='layout-footer-additional'}
                    {row class="footer-social-media"}
                    {block name='layout-footer-copyright'}
                        {col cols=12 sm=6 md=4 lg=2 id="copyright" class="footer-additional-wrapper"}
                        {assign var=isBrandFree value=JTL\Shop::isBrandfree()}
                        {block name='layout-footer-copyright-copyright'}
                            {if !empty($meta_copyright)}
                                <span class="icon-mr-2 text-white" itemprop="copyrightHolder">&copy; {$meta_copyright}</span>
                            {/if}
                            {if $Einstellungen.global.global_zaehler_anzeigen === 'Y'}
                                {lang key='counter'}: {$Besucherzaehler}
                            {/if}
                            {if !empty($Einstellungen.global.global_fusszeilehinweis)}
                                <span class="ml-2 text-white">{$Einstellungen.global.global_fusszeilehinweis}</span>
                            {/if}
                        {/block}
                        {if !$isBrandFree}
                            {block name='layout-footer-copyright-brand'}
                                {col class="col-auto ml-auto-util{if $Einstellungen.template.theme.button_scroll_top === 'Y'} pr-8{/if}" id="system-credits"}
                                    Powered by {link href="https://jtl-url.de/jtlshop" class="text-decoration-underline text-white" title="JTL-Shop" target="_blank" rel="noopener nofollow"}JTL-Shop{/link}
                                {/col}
                            {/block}
                        {/if}
                        {/col}
                    {/block}

                    {col cols=12 sm=4 class="footer-additional-wrapper d-flex align-items-center"}
                        <div class="footnote-vat text-white">
                            {if $NettoPreise == 1}
                                {lang key='footnoteExclusiveVat' assign='footnoteVat'}
                            {else}
                                {lang key='footnoteInclusiveVat' assign='footnoteVat'}
                            {/if}
                            {if isset($oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND])}
                                {if $Einstellungen.global.global_versandhinweis === 'zzgl'}
                                    {lang key='footnoteExclusiveShipping' printf=$oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND]->getURL() assign='footnoteShipping'}
                                {elseif $Einstellungen.global.global_versandhinweis === 'inkl'}
                                    {lang key='footnoteInclusiveShipping' printf=$oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND]->getURL() assign='footnoteShipping'}
                                {/if}
                            {/if}
                            {block name='footer-vat-notice'}
                                {$footnoteVat}{if isset($footnoteShipping)}{$footnoteShipping}{/if}
                            {/block}
                        </div>
                    {/col}
                    {if $Einstellungen.template.footer.socialmedia_footer === 'Y'}
                        {block name='layout-footer-socialmedia'}
                            {col cols=12 md=6 class="footer-additional-wrapper" id="footer-menu-wrapper"}

                            <div class="footer-bottom-menu container-fluid">
                                {foreach $footerBoxes as $box}
                                    {if $box->title[1] == "Gesetzliche Informationen"}
                                        {col cols=12}
                                        {$box->getRenderedContent()}
                                        {/col}
                                    {else}
                                    {/if}
                                {/foreach}
                            </div>


                            {/col}
                        {/block}
                    {/if}
                    {/row}{* /row footer-additional *}
                {/block}{* /footer-additional *}
                {/container}{* /container footer-additional *}

                {block name='layout-footer-scroll-top'}
                    {if $Einstellungen.template.theme.button_scroll_top === 'Y'}
                        {include file='snippets/scroll_top.tpl'}
                    {/if}
                {/block}
            </div>
        </footer>
    {/if}
{/block}



{else}
    {block name='layout-footer-content' }

    {if !$bExclusive}
        {$newsletterActive = $Einstellungen.template.footer.newsletter_footer === 'Y'
        && $Einstellungen.newsletter.newsletter_active === 'Y'}
        <footer id="footer" {if $newsletterActive}class="newsletter-active"{/if}>
            <div class="container-fluid container-fluid-xl d-print-none">
            {row id='footer-top'}
                {* <img src="/media/image/opc/lg/Logos/beautek_icon_bordeaux_rgb.png" class="footer-beautek-logo" alt="beautek-logo"> *}

                <svg fill="currentColor" width="60" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
                    viewBox="0 0 288 280" style="enable-background:new 0 0 288 280;" xml:space="preserve">
                <path class="st0" d="M232,106.7c-20.8-47-77.9-69.1-127.1-49.2c-24.4,9.9-43.1,28.3-52.7,51.9c-9.1,22.6-8.7,47.3,1.1,69.5
                    c15.6,35.3,51.6,56.5,89.4,56.5c12.6,0,25.4-2.4,37.7-7.3c24.4-9.9,43.1-28.3,52.7-51.9C242.2,153.7,241.8,129,232,106.7z
                    M159.2,175.6c-0.6,1.2-1.8,2.3-3.1,2.7c-2.5,0.8-4.8-1-5.6-3.1l-3.6-8.8l-0.2,1.8c-0.2,1.3-0.3,2.7-0.4,4c-0.1,1.3-0.2,2.4-0.3,3.5
                    c-0.8,5.9-3.2,11-7,15.2c-8,8.7-21.9,11.6-32.4,6.6c-5.3-2.5-9.2-6.9-10.3-11.5c-0.9-3.8,0.6-7.6,2.1-10.8c1.5-3.1,3.5-6.3,6.4-10.1
                    l1-1.3l-1.5,0.5c-2,0.7-4.6,1.5-7.5,1.6c-5.8,0.2-11-2.2-14.7-6.9c-1.2-1.5-2.3-3.4-3.3-5.2c-1.6-2.8-3.2-5.8-5.8-7.8
                    c-0.8-0.6-1.7-1.3-2.6-1.9c-4.1-2.9-8.1-5.7-6.5-11.2c1.8-6.2,9.5-6.2,15.2-6.3l0.1,0c7-0.1,14.2,0.7,21.3,2.3
                    c12.8,2.8,24.9,8.3,36,16.5c0,0,0.1,0,0.1,0c0.3,0.2,0.6,0.3,0.9,0.5l1.3,0.6l-0.3-1.1c-0.6-2.1,1.3-4.3,3.3-4.9
                    c2.3-0.7,4.1,0.6,5.1,2.1l0.6,0.8l0.4-1.2c0.1-0.3,0.2-0.6,0.3-0.9c1.7-12.4,6.4-24.5,13.5-35.1c3.6-5.4,7.7-10.3,12.3-14.7l0.8-0.8
                    c4.1-4,9.2-8.9,15-7.2c6.8,2,6.2,9.5,5.2,13.8c-1,4.1,0.1,7.9,1.1,11.7c0.6,2.2,1.2,4.5,1.4,6.8c0.5,6.1-2.2,11.5-7.6,15.3
                    c-1.3,0.9-2.7,1.7-4.4,2.5l-1.4,0.7l1.5,0.3c8,1.5,17.8,4.1,21.7,10.6c2.1,3.4,2.3,7.7,0.8,12.8c-3.2,10.5-14.8,18.2-26.9,17.9
                    c-6.3-0.2-12.1-2.2-17.4-6.2c-1-0.7-2-1.6-3-2.5c-1.2-1-2.4-2.1-3.8-3.1l-1.4-1.1l4.1,9.9C159.8,174,159.5,174.9,159.2,175.6z"/>
                </svg>

            {/row}
            {if $newsletterActive}
                {block name='layout-footer-newsletter'}
                    {row class="newsletter-footer"}
                    {col cols=12 lg=6}
                    {block name='layout-footer-newsletter-heading'}
                        <div class="h2 newsletter-footer-heading">
                            {lang key='newsletter' section='newsletter'} {lang key='newsletterSendSubscribe' section='newsletter'}
                        </div>
                    {/block}
                    {if isset($oSpezialseiten_arr[$smarty.const.LINKTYP_DATENSCHUTZ])}
                        {block name='layout-footer-newsletter-info'}
                            <p class="info">
                                {lang key='newsletterInformedConsent' section='newsletter' printf=$oSpezialseiten_arr[$smarty.const.LINKTYP_DATENSCHUTZ]->getURL()}
                            </p>
                        {/block}
                    {/if}
                    {/col}
                    {col cols=12 lg=6}
                    {block name='layout-footer-form'}
                        {form methopd="post" action="{get_static_route id='newsletter.php'}"}
                        {block name='layout-footer-form-content'}
                            {input type="hidden" name="abonnieren" value="2"}
                            {formgroup class="newsletter-email-wrapper"
								label-for="newsletter_email"
                                label="{lang key='newsletter' section='newsletter'} {lang key='newsletterSendSubscribe' section='newsletter'}"
                                label-sr-only=true}
                            {inputgroup}
                            {input type="email" name="cEmail" id="newsletter_email" placeholder="{lang key='emailadress'}" autocomplete="email"}
                            {inputgroupaddon append=true}
                            {button type='submit' variant='secondary' class='min-w-sm'}
                            {lang key='newsletterSendSubscribe' section='newsletter'}
                            {/button}
                            {/inputgroupaddon}
                            {/inputgroup}
                            {/formgroup}
                        {/block}
                        {block name='layout-footer-form-captcha'}
                            <div class="{if !empty($plausiArr.captcha) && $plausiArr.captcha === true} has-error{/if}">
                                {captchaMarkup getBody=true}
                            </div>
                        {/block}
                        {/form}
                    {/block}
                    {/col}
                    {/row}
                    <hr>
                {/block}
            {/if}
            {block name='layout-footer-boxes'}
                {getBoxesByPosition position='bottom' assign='footerBoxes'}
                {if isset($footerBoxes) && count($footerBoxes) > 0}
                    {row id='footer-boxes' class="standard-boxes"}
                    {foreach $footerBoxes as $box}
                        {if $box->isActive() && !empty($box->getRenderedContent())}
                            {col cols=12 sm=6 md=4 lg=3}
                            {$box->getRenderedContent()}
                            {/col}
                        {/if}
                    {/foreach}
                    {/row}
                {/if}
            {/block}
            </div>
            <div class="footer-payment-row">
            </div>
            <div class="footer-bottom-background-switch">

                {container class="d-print-none container-fluid-xl" fluid=true}
				{block name='layout-footer-withdrawal'}
                        {row class="withdrawal-link-wrapper"}
                            {col cols=12 sm=6 md=4 lg=3}
                                {include file='snippets/withdrawal_link.tpl'}
                            {/col}
                        {/row}
                    {/block}
                {block name='layout-footer-additional'}
                    {row class="footer-social-media"}
                    {block name='layout-footer-copyright'}
                        {col cols=12 sm=3 id="copyright" class="footer-additional-wrapper"}
                        {assign var=isBrandFree value=JTL\Shop::isBrandfree()}
                        {block name='layout-footer-copyright-copyright'}
                            {if !empty($meta_copyright)}
                                <span class="icon-mr-2 text-white" itemprop="copyrightHolder">&copy; {$meta_copyright}</span>
                            {/if}
                            {if $Einstellungen.global.global_zaehler_anzeigen === 'Y'}
                                {lang key='counter'}: {$Besucherzaehler}
                            {/if}
                            {if !empty($Einstellungen.global.global_fusszeilehinweis)}
                                <span class="ml-2 text-white">{$Einstellungen.global.global_fusszeilehinweis}</span>
                            {/if}
                        {/block}
                        {if !$isBrandFree}
                            {block name='layout-footer-copyright-brand'}
                                {col class="col-auto ml-auto-util{if $Einstellungen.template.theme.button_scroll_top === 'Y'} pr-8{/if}" id="system-credits"}
                                    Powered by {link href="https://jtl-url.de/jtlshop" class="text-white text-decoration-underline" title="JTL-Shop" target="_blank" rel="noopener"}JTL-Shop{/link}
                                {/col}
                            {/block}
                        {/if}
                        {/col}
                    {/block}

                    {col cols=12 sm=6 class="footer-additional-wrapper d-flex align-items-center"}
                        <div class="footnote-vat text-white">
                            {if $NettoPreise == 1}
                                {lang key='footnoteExclusiveVat' assign='footnoteVat'}
                            {else}
                                {lang key='footnoteInclusiveVat' assign='footnoteVat'}
                            {/if}
                            {if isset($oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND])}
                                {if $Einstellungen.global.global_versandhinweis === 'zzgl'}
                                    {lang key='footnoteExclusiveShipping' printf=$oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND]->getURL() assign='footnoteShipping'}
                                {elseif $Einstellungen.global.global_versandhinweis === 'inkl'}
                                    {lang key='footnoteInclusiveShipping' printf=$oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND]->getURL() assign='footnoteShipping'}
                                {/if}
                            {/if}
                            {block name='footer-vat-notice'}
                                {$footnoteVat}{if isset($footnoteShipping)}{$footnoteShipping}{/if}
                            {/block}
                        </div>
                    {/col}
                    {if $Einstellungen.template.footer.socialmedia_footer === 'Y'}
                        {block name='layout-footer-socialmedia'}
                            {col cols=12 sm=3 class="footer-additional-wrapper" id="social-media-wrapper"}
                            
                                <ul class="list-unstyled">
                                    {if !empty($Einstellungen.template.footer.facebook)}
                                        <li>
                                            {link href="{if $Einstellungen.template.footer.facebook|strpos:'http' !== 0}https://{/if}{$Einstellungen.template.footer.facebook}"
                                            class="btn-icon-beautek btn-facebook btn btn-sm" aria=['label'=>"{lang key='visit_us_on' section='aria' printf='Facebook'}"] title="Facebook" target="_blank" rel="noopener"}
                                            {literal}

                                                <svg width="31" height="31" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
                                                    viewBox="0 0 141.7 141.7" style="enable-background:new 0 0 141.7 141.7;" xml:space="preserve">
                                                <style type="text/css">
                                                    .st0{fill-rule:evenodd;clip-rule:evenodd;fill:#FFFFFF;}
                                                </style>
                                                <path class="st0" d="M101,18.6H40.7c-10,0-18.1,8.1-18.1,18.1l0,0V97c0,10,8.1,18.1,18.1,18.1l0,0H101c10,0,18.1-8.1,18.1-18.1l0,0
                                                    V36.7C119.1,26.7,111,18.6,101,18.6L101,18.6z M98.6,70.6h-9V104H74.5V70.6h-5.9V59.4h5.9v-7.2c0-9.4,3.9-15,15-15h11.2v11.2h-6.5
                                                    c-4.3,0-4.6,1.6-4.6,4.6v6.3h10.3L98.6,70.6L98.6,70.6z"/>
                                                </svg>
                                                
                                            {/literal}
                                            {/link}
                                        </li>
                                    {/if}
                                    {if !empty($Einstellungen.template.footer.twitter)}
                                        <li>
                                            {link href="{if $Einstellungen.template.footer.twitter|strpos:'http' !== 0}https://{/if}{$Einstellungen.template.footer.twitter}"
                                            class="btn-icon-beautek btn-twitter btn btn-sm" aria=['label'=>"{lang key='visit_us_on' section='aria' printf='Twitter'}"] title="Twitter" target="_blank" rel="noopener"}
                                                <i class="fab fa-twitter fa-fw fa-lg"></i>
                                            {/link}
                                        </li>
                                    {/if}
                                    {if !empty($Einstellungen.template.footer.youtube)}
                                        <li>
                                            {link href="{if $Einstellungen.template.footer.youtube|strpos:'http' !== 0}https://{/if}{$Einstellungen.template.footer.youtube}"
                                            class="btn-icon-beautek btn-youtube btn btn-sm" aria=['label'=>"{lang key='visit_us_on' section='aria' printf='YouTube'}"] title="YouTube" target="_blank" rel="noopener"}
                                                <i class="fab fa-youtube fa-fw fa-lg"></i>
                                            {/link}
                                        </li>
                                    {/if}
                                    {if !empty($Einstellungen.template.footer.vimeo)}
                                        <li>
                                            {link href="{if $Einstellungen.template.footer.vimeo|strpos:'http' !== 0}https://{/if}{$Einstellungen.template.footer.vimeo}"
                                            class="btn-icon-beautek btn-vimeo btn btn-sm" aria=['label'=>"{lang key='visit_us_on' section='aria' printf='Vimeo'}"]  title="Vimeo" target="_blank" rel="noopener"}
                                                <i class="fab fa-vimeo-v fa-fw fa-lg"></i>
                                            {/link}
                                        </li>
                                    {/if}
                                    {if !empty($Einstellungen.template.footer.instagram)}
                                        <li>
                                            {link href="{if $Einstellungen.template.footer.instagram|strpos:'http' !== 0}https://{/if}{$Einstellungen.template.footer.instagram}"
                                            class="btn-icon-beautek btn-instagram btn btn-sm" aria=['label'=>"{lang key='visit_us_on' section='aria' printf='Instagram'}"]  title="Instagram" target="_blank" rel="noopener"}
                                                <svg width="29" height="29" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
                                                    viewBox="0 0 141.7 141.7" style="enable-background:new 0 0 141.7 141.7;" xml:space="preserve">
                                                <path fill="#ffffff" class="st0" d="M53.4,71.5c0-10,8.1-18.2,18.1-18.2c10,0,18.2,8.1,18.2,18.1c0,10-8.1,18.2-18.1,18.2c0,0,0,0,0,0
                                                    C61.5,89.6,53.4,81.5,53.4,71.5C53.4,71.4,53.4,71.4,53.4,71.5 M43.5,71.4c0,15.5,12.5,28,28,28s28-12.5,28-28c0-15.5-12.5-28-28-28
                                                    h0C56.1,43.5,43.5,56,43.5,71.4 M94.1,42.4c0,3.6,2.9,6.5,6.5,6.5c3.6,0,6.5-2.9,6.5-6.5c0-3.6-2.9-6.5-6.5-6.5l0,0l0,0
                                                    C97,35.8,94.1,38.7,94.1,42.4 M49.5,115.8c-3.5,0-6.9-0.7-10.1-1.9c-2.4-0.9-4.5-2.3-6.3-4.1c-1.8-1.8-3.2-3.9-4.1-6.3
                                                    c-1.2-3.2-1.8-6.7-1.9-10.1c-0.3-5.7-0.3-7.5-0.3-22.1s0-16.3,0.3-22.1c0-3.5,0.7-6.9,1.9-10.1c0.9-2.4,2.3-4.5,4.1-6.3
                                                    c1.8-1.8,3.9-3.2,6.3-4.1c3.2-1.2,6.7-1.8,10.1-1.9c5.8-0.3,7.5-0.3,22.1-0.3s16.3,0,22.1,0.3c3.5,0,6.9,0.7,10.1,1.9
                                                    c2.4,0.9,4.5,2.3,6.3,4.1c1.8,1.8,3.2,3.9,4.1,6.3c1.2,3.2,1.8,6.7,1.9,10.1c0.3,5.8,0.3,7.5,0.3,22.1s0,16.3-0.3,22.1
                                                    c0,3.5-0.7,6.9-1.9,10.1c-0.9,2.4-2.2,4.5-4.1,6.3c-1.8,1.8-3.9,3.2-6.3,4.1c-3.2,1.2-6.7,1.8-10.1,1.9c-5.8,0.3-7.5,0.3-22.1,0.3
                                                    S55.3,116.1,49.5,115.8 M49,17.3c-4.5,0.1-9,0.9-13.2,2.5c-7.3,2.8-13.1,8.6-15.9,15.9c-1.6,4.2-2.4,8.7-2.5,13.2
                                                    c-0.3,5.8-0.3,7.7-0.3,22.5s0,16.7,0.3,22.5c0.1,4.5,0.9,9,2.5,13.2c2.8,7.3,8.6,13.1,15.9,16c4.2,1.6,8.7,2.4,13.2,2.5
                                                    c5.8,0.3,7.7,0.3,22.5,0.3s16.7,0,22.5-0.3c4.5-0.1,9-0.9,13.2-2.5c7.3-2.8,13.1-8.6,15.9-15.9c1.6-4.2,2.4-8.7,2.5-13.2
                                                    c0.3-5.8,0.3-7.7,0.3-22.5s0-16.7-0.3-22.5c-0.1-4.5-0.9-9-2.5-13.2c-2.8-7.3-8.6-13.1-15.9-15.9c-4.2-1.6-8.7-2.5-13.2-2.5
                                                    c-5.8-0.3-7.7-0.3-22.5-0.3S54.8,17,49,17.3"/>
                                                </svg>
                                            {/link}
                                        </li>
                                    {/if}
                                    {if !empty($Einstellungen.template.footer.skype)}
                                        <li>
                                            {link href="{if $Einstellungen.template.footer.skype|strpos:'http' !== 0}https://{/if}{$Einstellungen.template.footer.skype}"
                                            class="btn-icon-beautek btn-skype btn btn-sm" aria=['label'=>"{lang key='visit_us_on' section='aria' printf='Skype'}"]  title="Skype" target="_blank" rel="noopener"}
                                                <i class="fab fa-skype fa-fw fa-lg"></i>
                                            {/link}
                                        </li>
                                    {/if}
                                    {if !empty($Einstellungen.template.footer.xing)}
                                        <li>
                                            {link href="{if $Einstellungen.template.footer.xing|strpos:'http' !== 0}https://{/if}{$Einstellungen.template.footer.xing}"
                                            class="btn-icon-beautek btn-xing btn btn-sm" aria=['label'=>"{lang key='visit_us_on' section='aria' printf='Xing'}"]  title="Xing" target="_blank" rel="noopener"}
                                                <i class="fab fa-xing fa-fw fa-lg"></i>
                                            {/link}
                                        </li>
                                    {/if}
                                    {if !empty($Einstellungen.template.footer.linkedin)}
                                        <li>
                                            {link href="{if $Einstellungen.template.footer.linkedin|strpos:'http' !== 0}https://{/if}{$Einstellungen.template.footer.linkedin}"
                                            class="btn-icon-beautek btn-linkedin btn btn-sm" aria=['label'=>"{lang key='visit_us_on' section='aria' printf='Linkedin'}"]  title="Linkedin" target="_blank" rel="noopener"}
                                                <svg width="28" height="28" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 141.7 141.7" style="enable-background:new 0 0 141.7 141.7;" xml:space="preserve">
                                                <path fill="#ffffff" class="st0" d="M115.6,18.3H26.1c-4.2-0.1-7.7,3.3-7.8,7.5v90c0.1,4.2,3.5,7.6,7.8,7.5h89.5c4.2,0.1,7.7-3.3,7.8-7.5
                                                    c0,0,0,0,0,0v-90C123.3,21.6,119.9,18.3,115.6,18.3C115.6,18.3,115.6,18.3,115.6,18.3z M34.6,106.3V59h15.7v47.3H34.6z M42.4,52.4
                                                    h-0.1c-4.5,0.3-8.4-3.1-8.7-7.6c0-0.2,0-0.4,0-0.6c0-4.6,3.5-8.2,8.9-8.2c4.5-0.3,8.4,3,8.8,7.5c0,0.2,0,0.4,0,0.6
                                                    C51.3,48.9,47.9,52.5,42.4,52.4L42.4,52.4z M106.9,106.3H91.3V81c0-6.4-2.3-10.7-8-10.7c-3.6,0-6.9,2.3-8.1,5.8
                                                    c-0.4,1.2-0.6,2.5-0.5,3.8v26.4H59c0,0,0.2-42.9,0-47.3h15.7v6.7c2.9-5,8.3-8.1,14.2-7.8c10.3,0,18.1,6.7,18.1,21.3L106.9,106.3z"/>
                                                </svg>
                                            {/link}
                                        </li>
                                    {/if}
                                    {if !empty($Einstellungen.template.footer.pinterest)}
                                        <li>
                                            {link href="{if $Einstellungen.template.footer.pinterest|strpos:'http' !== 0}https://{/if}{$Einstellungen.template.footer.pinterest}"
                                            class="btn-icon-beautek btn-pinterest btn btn-sm" aria=['label'=>"{lang key='visit_us_on' section='aria' printf='Pinterest'}"]  title="Pinterest" target="_blank" rel="noopener"}
                                                <svg width="30" height="30" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" x="0px" y="0px" viewBox="0 0 141.7 141.7" style="enable-background:new 0 0 141.7 141.7;" xml:space="preserve">
                                                <path fill="#ffffff" d="M70.9,17C41.1,17,17,41.1,17,70.8c0,21.9,13.2,41.6,33.5,49.8c-2.3-17.6,4.1-30.8,7.2-45  c-5.2-8.4,0.6-25.2,11.7-21.1c13.6,5.1-11.8,31.2,5.2,34.5c17.7,3.4,25-29.4,14-40C72.6,33.6,42.3,48.6,46,70.6c0.5,2.7,5,7,5,7  c-0.3,2.5-0.8,5-1.4,7.4c-10.2-2.1-14.5-9.8-14.1-20c0.6-16.7,15.8-28.4,30.9-30C85.5,33,103.5,41.8,106,59  c2.8,19.4-8.6,40.4-29.2,38.9c-5.6-0.4-7.9-3-12.2-5.6c-2.3,11.5-5.1,22.6-13.1,28.8c27.7,10.7,58.9-3.1,69.6-30.8  c10.7-27.7-3.1-58.9-30.8-69.6C84.1,18.3,77.5,17,70.9,17L70.9,17z"/>
                                                </svg>
                                            {/link}
                                        </li>
                                    {/if}
                                </ul>
                            {/col}
                        {/block}
                    {/if}
                    {/row}{* /row footer-additional *}
                {/block}{* /footer-additional *}
                {/container}{* /container footer-additional *}

                {block name='layout-footer-scroll-top'}
                    {if $Einstellungen.template.theme.button_scroll_top === 'Y'}
                        {include file='snippets/scroll_top.tpl'}
                    {/if}
                {/block}
            </div>
        </footer>
    {/if}
{/block}
{/if}


{literal}
    <script>
    window.REQUIRED_CODE_ERROR_MESSAGE = 'Wählen Sie bitte einen Ländervorwahl aus.';
    window.LOCALE = 'de';
    window.EMAIL_INVALID_MESSAGE = window.SMS_INVALID_MESSAGE = "Die eingegebenen Informationen sind nicht gültig. Bitte überprüfen Sie das Feldformat und versuchen Sie es erneut.";
    window.REQUIRED_ERROR_MESSAGE = "Dieses Feld darf nicht leer sein. ";
    window.GENERIC_INVALID_MESSAGE = "Die eingegebenen Informationen sind nicht gültig. Bitte überprüfen Sie das Feldformat und versuchen Sie es erneut.";
    window.translation = {
        common: {
            selectedList: '{quantity} Liste ausgewählt',
            selectedLists: '{quantity} Listen ausgewählt'
        }
    };
    var AUTOHIDE = Boolean(0);
    </script>
    <script defer src="https://sibforms.com/forms/end-form/build/main.js" onerror="console.warn('Brevo form script unavailable');"></script>
{/literal}
