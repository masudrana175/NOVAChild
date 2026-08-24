{block name='productdetails-config-sidebar'}
    <div id="product-configuration-sidebar">
        {block name='productdetails-config-sidebar-table'}
            <table id="configuration-table" class="table table-striped">
                <tbody class="summary"></tbody>
                <tfoot>
                <tr>
                    <td colspan="3" class="cfg-price">
                        <strong class="price"></strong>
                        <p class="vat_info">
                            {block name='productdetails-config-sidebar-include-shipping-tax-info'}
                                <small>{include file='snippets/shipping_tax_info.tpl' taxdata=$Artikel->taxData}</small>
                            {/block}
                        </p>
                    </td>
                </tr>
                </tfoot>
            </table>
        {/block}
        {*{button variant="primary" class="float-right mb-3 js-cfg-validate" data=["dismiss"=>"modal"] disabled=true}
            {lang key='applyConfiguration' section='productDetails'}
        {/button}*}
        {* Bei ?v=cfg liegt Warenkorb + PayPal bereits in der Buybox – hier nicht doppelt rendern *}
        {if empty($beautekCfgPills)}
            {include file='productdetails/basket.tpl'}
            {if isset($kEditKonfig)}
                <input type="hidden" name="kEditKonfig" value="{$kEditKonfig}"/>
            {/if}
        {/if}

                                {if $Artikel->bHasKonfig == true}

                                  {block name="custom_paypal_config"}

                                            {if $preis >= 100}
    
                                                {assign var="telNumber" value="+49 (0) 271 313 743 0"}
                                                {assign var="telNumberLink" value="+4902713137430"}
                                                {assign var="imgOne" value="/templates/NOVAChild/themes/base/images/3.png"}
                                                {assign var="imgFour" value="/templates/NOVAChild/themes/base/images/8.png"}
    
                                                
                                                {assign var="klarnaImg" value="/templates/NOVAChild/themes/base/images/klarna.png"}
                                                {assign var="googleImg" value="/templates/NOVAChild/themes/base/images/google.png"}
    
                                                {assign var="nameOne" value="Laura Hees-Meiswinkel"}
                                                {assign var="nameFour" value="Marie-Teresa Klein"}
    
                                                {$persOneArray = array($imgOne, $nameOne)}
                                                {$persFourArray = array($imgFour, $nameFour)}
    
                                                {$mainArray = array($persOneArray, $persFourArray)}
    
                                                <span class="array_shuffle">
                                                {$mainArray|@shuffle}
                                                </span>
    
                                                    <div id="cstmPayPal" class="cstm-contact-banner config">
                                                        <div class="btc_contact-section">	
                                                            <div class="btc_contact-grid">
                                                                <div class="btc_profile-section">
                                                                    <div class="btc_profile-image-wrapper">
                                                                        <img src="{$mainArray[0][0]}" alt="{$mainArray[0][1]}">
                                                                    </div>
                                                                    <div class="btc_profile-name">{$mainArray[0][1]}</div>
                                                                    <div class="btc_profile-title">{lang key="serviceDisclaimer" section="custom"}</div>
                                                                </div>
                                                                <div class="btc_contact-items">
                                                                    <h2 class="btc_section-title">Noch Fragen?</h2>
                                                                    <h4 class="btc_sub_section-title">Ich bin gerne für dich da!</h4>
                                                                    <a href="#" class="btc_contact-item btc_contact-link question custom-question btc_contact-details" data-toggle="modal" data-target="#question-popup-{$Artikel->kArtikel}">
                                                                        <div class="btc_contact-icon">
                                                                            <svg viewBox="0 0 125 125" xmlns="http://www.w3.org/2000/svg">
                                                                                <path d="m105.182 97.82h-85.364a10.477 10.477 0 0 1 -10.465-10.466v-52.72a10.477 10.477 0 0 1 10.465-10.466h85.364a10.477 10.477 0 0 1 10.465 10.466v52.72a10.477 10.477 0 0 1 -10.465 10.466zm-85.364-69.652a6.472 6.472 0 0 0 -6.465 6.466v52.72a6.472 6.472 0 0 0 6.465 6.466h85.364a6.472 6.472 0 0 0 6.465-6.466v-52.72a6.472 6.472 0 0 0 -6.465-6.466z"></path>
                                                                                <path d="m62.5 72.764a2 2 0 0 1 -1.324-.5l-48.2-42.548 2.647-3 46.877 41.384 46.879-41.379 2.647 3-48.2 42.548a1.994 1.994 0 0 1 -1.326.495z"></path>
                                                                                <path d="m5.012 72.393h49.061v4h-49.061z" transform="matrix(.66 -.752 .752 .66 -45.859 47.529)"></path>
                                                                                <path d="m93.454 49.862h4v49.062h-4z" transform="matrix(.752 -.66 .66 .752 -25.361 81.43)"></path>
                                                                            </svg>
                                                                        </div>
                                                                        <div class="btc_contact-details">					 
                                                                            <span class="btc_contact-label">{lang key='cstmQuestion' section='custom'}</span>
                                                                            Jetzt E-Mail Frage senden
                                                                        </div>
                                                                    </a>

                                                                    <a href="tel:{$telNumberLink}" class="btc_contact-link btc_contact-item">
                                                                        <div class="btc_contact-icon">
                                                                            <svg viewBox="0 0 64 64" xmlns="http://www.w3.org/2000/svg">
                                                                                <path d="m58.04248 46.769c-.04467-.05472-8.38567-7.94188-8.43908-7.99669a5.91476 5.91476 0 0 0 -8.14493.98307c-4.26864 5.35191-13.93522-4.63685-17.74558-11.07183-2.00832-4.47441.80123-6.21855 1.04051-6.436 3.34035-3.11619 2.20851-6.59227 1.09767-8.05027l-7.62841-8.67189c-4.86457-4.87439-11.12666 3.26135-11.99605 4.7643-7.29551 11.39 11.70967 31.56516 13.22064 33.17858.81736 1.00055 22.08128 22.2 33.38825 15.10869 1.4655-.78716 9.92965-6.74738 5.20698-11.80796zm-.63428 3.8335c-.39355 2.62891-4.17285 5.40723-5.5957 6.25586-10.147 6.04443-29.6748-13.5083-30.87207-14.72363-.28743-.30083-19.56216-20.47916-13.03433-30.76031.89663-1.3876 3.80288-5.0546 6.45425-5.35489a2.89625 2.89625 0 0 1 2.41406.88281l7.52491 8.5542c.19873.27 1.852 2.6958-.85254 5.27442-1.522 1.04-3.70264 4.12744-1.522 8.84668a30.031 30.031 0 0 0 2.97313 4.28221 32.34206 32.34206 0 0 0 9.29982 8.34962c4.58155 2.32569 7.74366.26123 8.83789-1.22217 2.68506-2.60644 5.04444-.87109 5.24659-.71484l8.30224 7.86621a2.91013 2.91013 0 0 1 .82375 2.46387z"></path>
                                                                            </svg>
                                                                        </div>
                                                                        <div class="btc_contact-details">
                                                                            <span class="btc_contact-label">{lang key="telDisclaimer" section="custom"}</span>
                                                                            {$telNumber}
                                                                        </div>
                                                                    </a>
                                                                </div>            
                                                            </div>
                                                        </div>


                                                        {*
                                                        <div class="banner-bottom">
                                                            <div class="banner-bottom-img">
                                                                <img src={$paypalImg} alt="paypal" />
                                                            </div>
                                                            <div class="banner-bottom-img">
                                                                <img src={$klarnaImg} alt="klarna" />
                                                            </div>
                                                            <div class="banner-bottom-img">
                                                                <img src={$googleImg} alt="google" />
                                                            </div>
                                                        </div>
                                                        *}

                                                    </div>
                                            {/if}
                                        {/block}

                                {/if}


    </div>
{/block}
