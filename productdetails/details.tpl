
{block name='productdetails-details'}
    {*{has_boxes position='left' assign='hasLeftBox'}*}
    {$hasLeftBox = false}

    {* Fallback, falls Header-Snippet nicht geladen wurde *}
    {if !isset($beautekPdpV2)}
        {include file='snippets/beautek_pdp_v2_flag.tpl'}
    {/if}
    {if !isset($beautekCfgPills)}
        {include file='snippets/beautek_cfg_pills_flag.tpl'}
    {/if}

    {if $beautekPdpV2}
        <div class="beautek-pdp-v2-banner" role="status">
            <strong>PDP-Vorschau aktiv</strong>
            <span>Neue Produktseite (Testkreis) · Parameter <code>?v=pdp2</code> · Abschalten: <a href="?v=off">?v=off</a></span>
        </div>
    {/if}
    {if $beautekCfgPills}
        <div class="beautek-cfg-pills-banner" role="status">
            <strong>Konfigurator-Pills aktiv</strong>
            <span>UX wie Variationsartikel · Parameter <code>?v=cfg</code> · Abschalten: <a href="?v=off">?v=off</a></span>
        </div>
    {/if}

    {container class="{if $Einstellungen.template.theme.left_sidebar === 'Y' && $boxesLeftActive}container-plus-sidebar{/if}"}
        {if isset($bWarenkorbHinzugefuegt) && $bWarenkorbHinzugefuegt}
            {block name='productdetails-details-include-pushed-success'}
                {include file='productdetails/pushed_success.tpl' card=true}
            {/block}
        {else}
            {block name='productdetails-details-alert-product-note'}
                {$alertList->displayAlertByKey('productNote')}
            {/block}
        {/if}
    {/container}
    {block name='productdetails-details-form'}
        {* {if $smarty.server.REMOTE_ADDR == '130.180.64.138'}
            <pre>{$Artikel->oKategorie_arr|var_dump}</pre>
        {/if} *}
        {opcMountPoint id='opc_before_buy_form' inContainer=false}
        {container class="{if $Einstellungen.template.theme.left_sidebar === 'Y' && $boxesLeftActive}container-plus-sidebar{/if}"}
            {form id="buy_form{if !empty($smarty.get.quickView)}-quickview{/if}" action=$Artikel->cURLFull class="jtl-validate"}
			{button aria=["label"=>"{lang key='addToCart'}"]
                    name="inWarenkorb"
                    variant="hidden"
                    type="submit"
                    value="{lang key='addToCart'}"
					tabindex="-1"
                    disabled=$Artikel->bHasKonfig && !$isConfigCorrect|default:false
                    class="js-cfg-validate btn-hidden-default"
                    tabindex="-1"
                    aria-hidden="true"}{/button}
                {row id="product-offer" class="product-detail custom-detail"}
                    {block name='productdetails-details-include-image'}
                        {col cols=12 lg=6 class="product-gallery"}
                            {opcMountPoint id='opc_before_gallery'}
                            {include file='productdetails/image.tpl'}
                            {opcMountPoint id='opc_after_gallery'}
                        {/col}
                    {/block}
                    {col cols=12 lg=6 class="product-info"}
                        {block name='productdetails-details-info'}
                        <div class="product-info-inner">
                            <div class="product-info-firstrow">

								<div class="product-headline-wrap">
									<div class="product-headline">
										{block name='productdetails-details-info-product-title'}
											{opcMountPoint id='opc_before_headline'}
											{* Anzeigetitel live: Wawi-Name bleibt in data-full-name, sichtbar gekürzt *}
											{if isset($Artikel->FunktionsAttribute['beautek_anzeigetitel']) && $Artikel->FunktionsAttribute['beautek_anzeigetitel'] !== ''}
												{assign var='beautekDisplayTitle' value=$Artikel->FunktionsAttribute['beautek_anzeigetitel'] scope='global'}
												{assign var='beautekSubtitle' value=$Artikel->FunktionsAttribute['beautek_unterzeile']|default:'' scope='global'}
											{else}
												{$beautekNormName = $Artikel->cName|replace:' I ':'|'|replace:' | ':'|'}
												{$beautekTitleParts = '|'|explode:$beautekNormName}
												{assign var='beautekDisplayTitle' value=$beautekTitleParts[0]|trim scope='global'}
												{assign var='beautekSubtitle' value='' scope='global'}
												{if $beautekTitleParts|@count > 1}
													{foreach from=$beautekTitleParts item=beautekPart name=beautekTitleLoop}
														{if !$smarty.foreach.beautekTitleLoop.first}
															{if $beautekSubtitle !== ''}
																{assign var='beautekSubtitle' value=$beautekSubtitle|cat:' · ' scope='global'}
															{/if}
															{assign var='beautekSubtitle' value=$beautekSubtitle|cat:($beautekPart|trim) scope='global'}
														{/if}
													{/foreach}
												{/if}
											{/if}
											<h1 class="product-title h2 beautek-display-title" itemprop="name" data-full-name="{$Artikel->cName|escape:'html'}">{$beautekDisplayTitle}</h1>
											{if $beautekSubtitle !== ''}
												<p class="beautek-display-subtitle">{$beautekSubtitle}</p>
											{/if}
										{/block}
									</div>
								</div>

								<div class="rating-info">
								{block name='productdetails-details-info-essential-wrapper'}
								{if ($Artikel->Bewertungen->oBewertungGesamt->nAnzahl > 0) || isset($Artikel->cArtNr)}
									{if ($Einstellungen.bewertung.bewertung_anzeigen === 'Y' && $Artikel->Bewertungen->oBewertungGesamt->nAnzahl > 0)}
										{block name='productdetails-details-info-rating-wrapper'}
											<div class="rating-wrapper" itemprop="aggregateRating" itemscope itemtype="https://schema.org/AggregateRating">
												<meta itemprop="ratingValue" content="{$Artikel->Bewertungen->oBewertungGesamt->fDurchschnitt}"/>
												<meta itemprop="bestRating" content="5"/>
												<meta itemprop="worstRating" content="1"/>
												<meta itemprop="reviewCount" content="{$Artikel->Bewertungen->oBewertungGesamt->nAnzahl}"/>
												{block name='productdetails-details-include-rating'}
													{if empty($smarty.get.quickView)}
														{link href="{$Artikel->cURLFull}#tab-votes"
														id="jump-to-votes-tab"
														aria=["label"=>{lang key='Votes'}]
														}
														{include file='productdetails/rating.tpl' stars=$Artikel->Bewertungen->oBewertungGesamt->fDurchschnitt total=$Artikel->Bewertungen->oBewertungGesamt->nAnzahl}
														{* ({$Artikel->Bewertungen->oBewertungGesamt->nAnzahl} {lang key='rating'}) *}
													{/link}
													{else}
														{include file='productdetails/rating.tpl' stars=$Artikel->Bewertungen->oBewertungGesamt->fDurchschnitt total=$Artikel->Bewertungen->oBewertungGesamt->nAnzahl}
														({$Artikel->Bewertungen->oBewertungGesamt->nAnzahl} {lang key='rating'})
													{/if}
												{/block}
											</div>
										{/block}
									{/if}
									
									{block name='productdetails-details-info-essential'}
										<ul class="info-essential list-unstyled">


											{*  {block name='productdetails-details-info-mhd'}
												{if $Einstellungen.artikeldetails.show_shelf_life_expiration_date === 'Y'
												&& isset($Artikel->dMHD)
												&& isset($Artikel->dMHD_de)}
													<li class="product-mhd">
														<strong title="{lang key='productMHDTool'}">
															{lang key='productMHD'}:
														</strong>
														<span itemprop="best-before">{$Artikel->dMHD_de}</span>
													</li>
												{/if}
											{/block}
											{block name='productdetails-details-info-gtin'}
												{if !empty($Artikel->cBarcode)
												&& ($Einstellungen.artikeldetails.gtin_display === 'details'
												|| $Einstellungen.artikeldetails.gtin_display === 'always')}
													<li class="product-ean">
														<strong>{lang key='ean'}:</strong>
														<span itemprop="{if $Artikel->cBarcode|strlen === 8}gtin8{else}gtin13{/if}">{$Artikel->cBarcode}</span>
													</li>
												{/if}
											{/block}
											{block name='productdetails-details-info-han'}
												{if !empty($Artikel->cHAN)
												&& ($Einstellungen.artikeldetails.han_display === 'details'
												|| $Einstellungen.artikeldetails.han_display === 'always')}
													<li class="product-han">
														<strong>{lang key='han'}:</strong>
														<span itemprop="">{$Artikel->cHAN}</span>
													</li>
												{/if}
											{/block}
											{block name='productdetails-details-info-isbn'}
												{if !empty($Artikel->cISBN)
												&& ($Einstellungen.artikeldetails.isbn_display === 'D'
												|| $Einstellungen.artikeldetails.isbn_display === 'DL')}
													<li class="product-isbn">
														<strong>{lang key='isbn'}:</strong>
														<span itemprop="gtin13">{$Artikel->cISBN}</span>
													</li>
												{/if}
											{/block} *}

											{* {block name='productdetails-details-info-category-wrapper'}
												{assign var=cidx value=($Brotnavi|count)-2}
												{if $Einstellungen.artikeldetails.artikeldetails_kategorie_anzeigen === 'Y' && isset($Brotnavi[$cidx])}
													{block name='productdetails-details-info-category'}
														<li class="product-category word-break">
															<strong>{lang key='category'}: </strong>
															<a href="{$Brotnavi[$cidx]->getURLFull()}" itemprop="category"
															   {if !empty($smarty.get.quickView)}target="_blank"{/if}
															>
																{$Brotnavi[$cidx]->getName()}
															</a>
														</li>
													{/block}
												{/if}
											{/block} *}

											{* Artikelnummer & Hersteller: unter dem Kaufblock (product-meta-after-buy) *}



										   
											{block name='productdetails-details-hazard-info'}
												{if !empty($Artikel->cUNNummer) && !empty($Artikel->cGefahrnr)
												&& ($Einstellungen.artikeldetails.adr_hazard_display === 'D'
												|| $Einstellungen.artikeldetails.adr_hazard_display === 'DL')}
													<li class="product-hazard">
														<strong>{lang key='adrHazardSign'}:</strong>
														<table class="adr-table">
															<tr>
																<td>{$Artikel->cGefahrnr}</td>
															</tr>
															<tr>
																<td>{$Artikel->cUNNummer}</td>
															</tr>
														</table>
													</li>
												{/if}
											{/block}
										</ul>
									{/block}
									 
								{/if}
								{/block}
								</div>
                            </div>
						</div>
                            {block name='productdetails-details-info-description-wrapper'}
                            {if $Einstellungen.artikeldetails.artikeldetails_kurzbeschreibung_anzeigen === 'Y' && $Artikel->cKurzBeschreibung}
                                {block name='productdetails-details-info-description'}
                                    {opcMountPoint id='opc_before_short_desc'}
                                    <div class="shortdesc" itemprop="description">
                                        {$Artikel->cKurzBeschreibung}
                                    </div>
                                {/block}
                            {/if}
                            {opcMountPoint id='opc_after_short_desc'}
                            {/block}

                            <div class="product-offer{if $beautekPdpV2} beautek-pdp-v2-buybox{/if}"{if !($Artikel->Preise->fVKNetto == 0 && $Einstellungen.global.global_preis0 === 'N')} itemprop="offers" itemscope itemtype="https://schema.org/Offer"{/if}>
							
								{if $Artikel->bHasKonfig}                                
									{row}
										{if isset($Artikel->Variationen) && $Artikel->Variationen|count > 0}
											{block name='productdetails-details-config-button-info'}
												{col cols=12 class="js-choose-variations-wrapper"}
													{alert variation="info" class="choose-variations"}
														{lang key='chooseVariations' section='messages'}
													{/alert}
												{/col}
											{/block}
										{/if}
									{/row}	
								{/if}			
                                {block name='productdetails-details-info-hidden'}
                                    
                                    {if $Artikel->nIstVater && $Artikel->kVaterArtikel == 0}
                                        {block name='productdetails-basket-alert-choose'}
                                            {alert variation="info" class="choose-variations"}
                                                {lang key='chooseVariations' section='messages'}
                                            {/alert}
                                        {/block} 
                                    {/if}
                                    
                                    {if !($Artikel->Preise->fVKNetto == 0 && $Einstellungen.global.global_preis0 === 'N')}
                                        <meta itemprop="url" content="{$Artikel->cURLFull}">
                                        <link itemprop="businessFunction" href="http://purl.org/goodrelations/v1#Sell" />
                                    {/if}
                                    {input type="hidden" name="inWarenkorb" value="1"}
                                    {if $Artikel->kArtikelVariKombi > 0}
                                        {input type="hidden" name="aK" value=$Artikel->kArtikelVariKombi}
                                    {/if}
                                    {if isset($Artikel->kVariKindArtikel)}
                                        {input type="hidden" name="VariKindArtikel" value=$Artikel->kVariKindArtikel}
                                    {/if}
                                    {if isset($smarty.get.ek)}
                                        {input type="hidden" name="ek" value=intval($smarty.get.ek)}
                                    {/if}
                                    {input type="hidden" name="AktuellerkArtikel" class="current_article" name="a" value=$Artikel->kArtikel}
                                    {input type="hidden" name="wke" value="1"}
                                    {input type="hidden" name="show" value="1"}
                                    {input type="hidden" name="kKundengruppe" value=JTL\Session\Frontend::getCustomerGroup()->getID()}
                                    {input type="hidden" name="kSprache" value=JTL\Shop::getLanguageID()}
                                {/block}

                                {if $beautekPdpV2}
                                    {block name='productdetails-details-include-price-top-v2'}
                                        {if !($Artikel->Preise->fVKNetto == 0 && isset($Artikel->FunktionsAttribute[$smarty.const.FKT_ATTRIBUT_VOUCHER_FLEX]))}
                                            <div class="beautek-pdp-v2-price-top">
                                                {include file='productdetails/price.tpl' Artikel=$Artikel tplscope='detail' priceLarge=true}
                                            </div>
                                        {/if}
                                    {/block}
                                {/if}

                                {block name='productdetails-details-include-variation'}
                                    <!-- VARIATIONEN -->
                                    <div class="beautek-variations-wrap{if $beautekPdpV2} beautek-pdp-v2-variations{/if}">
                                        {include file='productdetails/variation.tpl' simple=$Artikel->isSimpleVariation showMatrix=$showMatrix}
                                    </div>
                                {/block}

                                {* Konfigurator-Pills (?v=cfg): kompakte Auswahl direkt in der Buybox *}
                                {if $beautekCfgPills && $Artikel->bHasKonfig && empty($smarty.get.quickView)}
                                    <div id="beautek-cfg-buybox" class="beautek-cfg-buybox" aria-label="Produkt konfigurieren"></div>
                                {/if}

                                {* {if $smarty.server.REMOTE_ADDR == '130.180.64.137'}                                       
                                    {col cols=12}
                                        {block name='productdetails-delivery-rate-info'}
                                            <div class="productdetails-delivery-rate">
                                                {assign var="paypalImg" value="/templates/NOVAChild/themes/base/images/paypal.png"}
                                                <div class="delivery-rate-inner">
                                                    <svg viewBox="0 0 48 48" xmlns="http://www.w3.org/2000/svg"><path d="m41.211 37.288a4.112 4.112 0 1 1 4.109-4.112 4.114 4.114 0 0 1 -4.109 4.112zm0-6.724a2.612 2.612 0 1 0 2.609 2.612 2.613 2.613 0 0 0 -2.609-2.612z"></path><path d="m19.542 37.288a4.112 4.112 0 1 1 4.108-4.112 4.115 4.115 0 0 1 -4.108 4.112zm0-6.724a2.612 2.612 0 1 0 2.608 2.612 2.614 2.614 0 0 0 -2.608-2.612z"></path><path d="m46.621 33.926h-2.051a.75.75 0 0 1 0-1.5h1.839v-3.977a3.16 3.16 0 0 0 -.4-1.536l-4.06-7.279a.4.4 0 0 0 -.349-.205h-5.533v13h1.786a.75.75 0 0 1 0 1.5h-2.536a.75.75 0 0 1 -.75-.75v-14.5a.75.75 0 0 1 .75-.75h6.283a1.9 1.9 0 0 1 1.66.974l4.059 7.28a4.662 4.662 0 0 1 .589 2.266v4.19a1.289 1.289 0 0 1 -1.287 1.287z"></path><path d="m16.183 33.926h-7.191a.75.75 0 0 1 -.75-.75v-5.768a.75.75 0 0 1 1.5 0v5.018h6.441a.75.75 0 0 1 0 1.5z"></path><path d="m8.992 24.747a.75.75 0 0 1 -.75-.75v-5.036a.75.75 0 0 1 1.5 0v5.039a.75.75 0 0 1 -.75.747z"></path><path d="m35.317 33.926h-12.417a.75.75 0 0 1 0-1.5h11.667v-19.621h-24.825v3.089a.75.75 0 0 1 -1.5 0v-3.227a1.364 1.364 0 0 1 1.363-1.362h25.1a1.364 1.364 0 0 1 1.362 1.362v20.509a.75.75 0 0 1 -.75.75z"></path><path d="m11.957 28.158h-9.519a.75.75 0 0 1 0-1.5h9.519a.75.75 0 0 1 0 1.5z"></path><path d="m19.542 24.747h-13.283a.75.75 0 0 1 0-1.5h13.283a.75.75 0 0 1 0 1.5z"></path><path d="m5.846 20.787h-5.187a.75.75 0 1 1 0-1.5h5.187a.75.75 0 0 1 0 1.5z"></path><path d="m14.163 16.644h-9.156a.75.75 0 1 1 0-1.5h9.156a.75.75 0 0 1 0 1.5z"></path></svg>
                                                    <div class="top-text"></div>
                                                </div>
                                            </div>
                                        {/block}
                                    {/col}
                                {/if} *}
								
                                {row}
                                    {block name='productdetails-details-include-price'}
                                        {if !($Artikel->Preise->fVKNetto == 0 && isset($Artikel->FunktionsAttribute[$smarty.const.FKT_ATTRIBUT_VOUCHER_FLEX]))}
                                            {col}
                                                {if !$beautekPdpV2}
                                                    {include file='productdetails/price.tpl' Artikel=$Artikel tplscope='detail' priceLarge=true}
                                                {/if}
												{* Badges vor dem Warenkorb: Sofort (nur Lagerbestand) + Lieferzeit (wenn vorhanden) *}
												{if (isset($Artikel->fLagerbestand) && $Artikel->fLagerbestand > 0) || !empty($Artikel->cEstimatedDelivery)}
													<div class="shipping-badges{if $beautekPdpV2} beautek-pdp-v2-delivery{/if}">
														{if isset($Artikel->fLagerbestand) && $Artikel->fLagerbestand > 0}
															<div class="estimated-delivery instant-shipping-green instant-shipping-badge">
																{if $beautekPdpV2}
																	<span class="beautek-pdp-v2-delivery-ico" aria-hidden="true">✓</span>
																{/if}
																<span class="instant-shipping-badge__title">Sofort versandfertig</span>
																<span class="instant-shipping-badge__meta">
																	{* Cutoff nur bei Paketversand + Lagerbestand, zeitgesteuert via JS *}
																	{if isset($Artikel->cVersandklasse) && ($Artikel->cVersandklasse|lower|strpos:'paketversand' !== false)}
																		<span class="instant-shipping-badge__cutoff js-shipping-cutoff"
																		      data-cutoff-hour="11"
																		      data-cutoff-text="Versand noch heute"></span>
																	{/if}
																</span>
															</div>
														{/if}
														{if !empty($Artikel->cEstimatedDelivery)}
															<div class="estimated-delivery shipping-time-badge">
																{if $beautekPdpV2}
																	<span class="beautek-pdp-v2-delivery-ico" aria-hidden="true">◷</span>
																{/if}
																<span class="shipping-time-badge__title">{if $beautekPdpV2}Lieferung{else}Lieferzeit{/if}</span>
																<span class="shipping-time-badge__value">{$Artikel->cEstimatedDelivery}</span>
															</div>
														{/if}
													</div>
												{/if}
                                            {/col}
                                        {/if}
                                    {/block}
									
									{col cols=12}
										{block name='productdetails-details-include-supplies'}
											<div class="custom-accordion" id="additional-supplies">
												<div class="svg-holder">
												</div>
											</div>
										{/block}
									{/col}
                                    {block name='productdetails-details-stock'}

                                        {col cols=12}
												{if !$Artikel->bHasKonfig || $beautekCfgPills}
													{if empty($smarty.get.quickView)}
														{include file='productdetails/basket.tpl'}
													{/if}
                                                {/if}

												{if $beautekPdpV2 && empty($smarty.get.quickView)}
													<div class="beautek-pdp-v2-cta-secondary">
														<a class="beautek-pdp-v2-beratung-btn" href="tel:+492713137430">Beratung anfragen</a>
													</div>
													<div class="beautek-pdp-v2-trust" aria-label="Vorteile">
														<span>14 Tage Widerruf</span>
														<span>Persönliche Beratung</span>
														<span>Ratenzahlung möglich</span>
													</div>
													<aside class="beautek-pdp-v2-advisor">
														<div class="beautek-pdp-v2-advisor-avatar" aria-hidden="true">MT</div>
														<div class="beautek-pdp-v2-advisor-body">
															<strong>Marie-Teresa Klein</strong>
															<p>Deine persönliche Beraterin · Mo–Fr 8:30–16:30</p>
															<p class="beautek-pdp-v2-advisor-links">
																<a href="tel:+492713137430">+49 271 313 743 0</a>
															</p>
														</div>
													</aside>
												{/if}
												
                                                {row class="rate-info-row"}
                                                    {col}
                                                        {block name='productdetails-details-rate-info'}
                                                            <div class="productdetails-details-rate">
                                                                {assign var="paypalImg" value="/templates/NOVAChild/themes/base/images/paypal.png"}
                                                                {$preis = $Artikel->Preise->fVKBrutto}
                                                                {$factor = 24}
                                                                {$priceEq = {math equation="x / y" x=$preis y=$factor}}
                                                                {$priceFinal = {$priceEq|string_format:"%.2f"}}

                                                                <div class="details-rate-inner">
                                                                    <img src={$paypalImg} alt="paypal" width="250" />
                                                                    <div class="top-text">
                                                                        <span class="rate-info">in 2-24 monatl. Raten zu nur <strong><span>{$priceFinal} €</span>/Monat</strong></span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        {/block}
                                                    {/col}
                                                {/row}



                                            {row no-gutters=true class="col-12 stock-information {if !isset($availability) && !isset($shippingTime)}stock-information-p{/if}"}
                                                {col sm=1}
                                                    <div class="svg-holder">
                                                        <svg id="delivery" viewBox="0 0 48 48" xmlns="http://www.w3.org/2000/svg"><path d="m41.211 37.288a4.112 4.112 0 1 1 4.109-4.112 4.114 4.114 0 0 1 -4.109 4.112zm0-6.724a2.612 2.612 0 1 0 2.609 2.612 2.613 2.613 0 0 0 -2.609-2.612z"></path><path d="m19.542 37.288a4.112 4.112 0 1 1 4.108-4.112 4.115 4.115 0 0 1 -4.108 4.112zm0-6.724a2.612 2.612 0 1 0 2.608 2.612 2.614 2.614 0 0 0 -2.608-2.612z"></path><path d="m46.621 33.926h-2.051a.75.75 0 0 1 0-1.5h1.839v-3.977a3.16 3.16 0 0 0 -.4-1.536l-4.06-7.279a.4.4 0 0 0 -.349-.205h-5.533v13h1.786a.75.75 0 0 1 0 1.5h-2.536a.75.75 0 0 1 -.75-.75v-14.5a.75.75 0 0 1 .75-.75h6.283a1.9 1.9 0 0 1 1.66.974l4.059 7.28a4.662 4.662 0 0 1 .589 2.266v4.19a1.289 1.289 0 0 1 -1.287 1.287z"></path><path d="m16.183 33.926h-7.191a.75.75 0 0 1 -.75-.75v-5.768a.75.75 0 0 1 1.5 0v5.018h6.441a.75.75 0 0 1 0 1.5z"></path><path d="m8.992 24.747a.75.75 0 0 1 -.75-.75v-5.036a.75.75 0 0 1 1.5 0v5.039a.75.75 0 0 1 -.75.747z"></path><path d="m35.317 33.926h-12.417a.75.75 0 0 1 0-1.5h11.667v-19.621h-24.825v3.089a.75.75 0 0 1 -1.5 0v-3.227a1.364 1.364 0 0 1 1.363-1.362h25.1a1.364 1.364 0 0 1 1.362 1.362v20.509a.75.75 0 0 1 -.75.75z"></path><path d="m11.957 28.158h-9.519a.75.75 0 0 1 0-1.5h9.519a.75.75 0 0 1 0 1.5z"></path><path d="m19.542 24.747h-13.283a.75.75 0 0 1 0-1.5h13.283a.75.75 0 0 1 0 1.5z"></path><path d="m5.846 20.787h-5.187a.75.75 0 1 1 0-1.5h5.187a.75.75 0 0 1 0 1.5z"></path><path d="m14.163 16.644h-9.156a.75.75 0 1 1 0-1.5h9.156a.75.75 0 0 1 0 1.5z"></path></svg>
                                                    </div>
                                                {/col}
												
                                                {col sm=11}
                                                    {block name='productdetails-details-include-stock'}
                                                        {include file='productdetails/stock.tpl'}
                                                    {/block}
                                                {/col}
												
												
                                                {col class="col-auto question-on-item" }
                                                    {* {block name='productdetails-details-question-on-item' }
                                                            <button type="button" id="f{$Artikel->kArtikel}"
                                                                    class="btn btn-link question"
                                                                    title="jetzt-anrufen" style="display:block;"
                                                                    >
                                                                    <a href="tel:+492713137430" class="btn btn-link" style="text-decoration:none; margin-left: -1.1rem;" > 
                                                                <svg width="20" height="20" fill="currentColor" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 90.7 90.7" style="enable-background:new 0 0 90.7 90.7;" xml:space="preserve">
                                                                <path d="M73,16.7c-0.7-2.9-2.2-5.4-4.5-7.2c-1-0.8-2.3-1.1-3.6-1c-1.3,0.2-2.4,0.8-3.2,1.9L47.5,28.9
                                                                    c-1.6,2.1-1.2,5.2,0.9,6.8c2.2,1.7,4.8,2.5,7.7,2.5c1,0,2.1-0.2,3.1-0.4c-1.7,3.6-4.2,7.9-7.9,12.8c-3.8,5-7.4,8.7-10.5,11.3
                                                                    c-0.2-4-1.9-7.5-4.9-9.8c-2.1-1.6-5.2-1.2-6.8,0.9L14.9,71.6c-1.6,2.1-1.2,5.2,0.9,6.8c2.2,1.7,4.8,2.5,7.7,2.5
                                                                    c0.4,0,0.8-0.1,1.1-0.1c1.4,0.8,3.3,1.5,5.9,1.5c3.2,0,7.3-1,12.5-4.2c6.7-4,13.7-10.6,19.8-18.6c6.1-8,10.6-16.5,12.7-24
                                                                    C78.7,24.4,75.6,19.1,73,16.7z"></path>
                                                                </svg>
                                                            <span class="" style="margin-left:-0.2rem;">Telefonisch bestellen</span>
                                                                
                                                            </a>
                                                            </button>
                                                    {/block} *}

                                                    {* {block name='productdetails-details-question-on-item'}
                                                        {if $Einstellungen.artikeldetails.artikeldetails_fragezumprodukt_anzeigen === 'P'
                                                            && empty($smarty.get.quickView)
                                                        }
                                                            <button type="button" id="z{$Artikel->kArtikel}"
                                                                    class="btn btn-link question"
                                                                    title="{lang key='productQuestion' section='productDetails'}"
                                                                    data-toggle="modal"
                                                                    data-target="#question-popup-{$Artikel->kArtikel}">
                                                                <span class="fa fa-question-circle"></span>
                                                                <span class="hidden-xs hidden-sm">{lang key='productQuestion' section='productDetails'}</span>
                                                            </button>
                                                        {/if}
                                                    {/block} *}
                                                    
                                                {/col} 

                                            {/row}

                                            {block name='snippets-stock-note-include-warehouse'}
                                                {if empty($smarty.get.quickView)}
													{include file='productdetails/warehouse.tpl'}
                                               {/if}
                                            {/block}

                                            {block name='productdetails-details-meta-after-buy'}
                                                {if isset($Artikel->cArtNr)
                                                    || ($Einstellungen.artikeldetails.artikeldetails_hersteller_anzeigen !== 'N' && isset($Artikel->cHersteller))}
                                                    <div class="product-meta-after-buy">
                                                        <ul class="list-unstyled mb-0">
                                                            {block name='productdetails-details-info-item-id-after-buy'}
                                                                {if isset($Artikel->cArtNr)}
                                                                    <li class="product-sku">
                                                                        <strong>{lang key='sortProductno'}:</strong>
                                                                        <span itemprop="sku">{$Artikel->cArtNr}</span>
                                                                    </li>
                                                                {/if}
                                                            {/block}
                                                            {block name='productdetails-details-info-manufacturer-after-buy'}
                                                                {if $Einstellungen.artikeldetails.artikeldetails_hersteller_anzeigen !== 'N' && isset($Artikel->cHersteller)}
                                                                    <li class="product-manufacturer-inline" itemprop="brand" itemscope itemtype="https://schema.org/Brand">
                                                                        <strong>{lang key='manufacturers'}:</strong>
                                                                        {if $Einstellungen.artikeldetails.artikel_weitere_artikel_hersteller_anzeigen === 'Y'}
                                                                            <a href="{if !empty($Artikel->cHerstellerHomepage)}{$Artikel->cHerstellerHomepage}{else}{$Artikel->cHerstellerURL}{/if}"
                                                                                {if $Einstellungen.artikeldetails.artikeldetails_hersteller_anzeigen === 'B'}
                                                                                    data-toggle="tooltip"
                                                                                    data-placement="left"
                                                                                    title="{$Artikel->cHersteller}"
                                                                                {/if}
                                                                                itemprop="url">
                                                                        {/if}
                                                                            {if ($Einstellungen.artikeldetails.artikeldetails_hersteller_anzeigen === 'B'
                                                                                || $Einstellungen.artikeldetails.artikeldetails_hersteller_anzeigen === 'BT')
                                                                                && !empty($Artikel->cHerstellerBildURLKlein)}
                                                                                {image lazy=true
                                                                                    webp=true
                                                                                    src=$Artikel->cHerstellerBildURLKlein
                                                                                    alt=$Artikel->cHersteller|escape:'html'
                                                                                }
                                                                                <meta itemprop="image" content="{$Artikel->cHerstellerBildURLKlein}">
                                                                            {/if}
                                                                            {if $Einstellungen.artikeldetails.artikeldetails_hersteller_anzeigen !== 'B'}
                                                                                <span itemprop="name">{$Artikel->cHersteller}</span>
                                                                            {/if}
                                                                        {if $Einstellungen.artikeldetails.artikel_weitere_artikel_hersteller_anzeigen === 'Y'}
                                                                            </a>
                                                                        {/if}
                                                                    </li>
                                                                {/if}
                                                            {/block}
                                                        </ul>
                                                    </div>
                                                {/if}
                                            {/block}
                                        {/col}
                                    {/block}
                                {/row}
								
                                {if $Artikel->bHasKonfig && !$beautekCfgPills}
                                {block name='productdetails-details-config-button'}
                                        {row}											
                                            {if !isset($Artikel->FunktionsAttribute['konfigurationsartikel_extra_warenkorb-button'])}
                                                {block name='productdetails-details-config-button-button'}
                                                    {col cols=12 class="mt-5 product-configurator-parent" id="product-configurator-button"}
                                                       {if $Einstellungen.template.productdetails.config_position === 'popup'}
														   {link class="btn btn-secondary" href="#product-configurator"}
																<i class="fas fa-cogs"></i> <span style="padding-left:1rem;">{lang key='configure'}</span> 
															{/link}
															{* button type="button"
																class="start-configuration js-start-configuration"
																value="{lang key='configure'}"
																block=true
																data=["toggle"=>"modal", "target"=>"#cfg-container"]
																disabled=(isset($Artikel->Variationen) && $Artikel->Variationen|count > 0)
															}
																<span>{lang key='configure'}</span> <i class="fas fa-cogs"></i>
															{/button *}
															{else}
															{link type="button"
																class="btn btn-secondary start-configuration js-start-configuration"
																value="{lang key='configure'}"
																block=true
																href="#cfg-container"
																disabled=(isset($Artikel->Variationen) && $Artikel->Variationen|count > 0)
															}
																<span>{lang key='configure'}</span> <i class="fas fa-cogs"></i>
															{/link}
														{/if}
                                                    {/col}
                                                {/block}
                                            {/if}

                                            {if isset($Artikel->FunktionsAttribute['konfigurationsartikel_extra_warenkorb-button'])}
                                                
                                                {block name='productdetails-details-config-checkout-button'}
                                                    {col cols=12 class='adaptive-configurator_wrapper'}
                                                        {col cols=12 sm=12 class="adaptive-configurator"}
                                                        <div class="text-wrapper">
                                                            <p>Passen Sie Ihr Produkt nach Ihren Bedürfnissen an</p>
                                                        </div>
                                                            {link class="btn btn-secondary" href="#product-configurator"}
                                                                <i class="fas fa-cogs"></i> <span style="padding-left:1rem;">{lang key='configure'}</span> 
                                                            {/link}
                                                        {/col}										
                                                    {/col}

                                                    {col  cols=12 class='adaptive-configurator_wrapper'}
                                                        {col  cols=12 sm=12 class="adaptive-configurator"}
                                                            <div class="input-group-wrapper">
                                                                <div class="input-group form-counter choose_quantity" id="quantity-grp" role="group">
                                                                    <div class="input-group-prepend">                                                
                                                                        <button type="button" class="btn btn-" aria-label="Menge verringern" data-count-down="">
                                                                            <span class="fas fa-minus"></span>       
                                                                        </button>                                        
                                                                    </div>
                                                                    <input type="number" class="form-control quantity" id="quantity_adaptive-configurator" value="1" min="0" step="1" name="anzahl" aria-label="Menge" data-decimals="0">
                                                                    <div class="input-group-append">
                                                                        <button type="button" class="btn btn-" aria-label="Menge erhöhen" data-count-up="">
                                                                            <span class="fas fa-plus"></span>                                       
                                                                        </button>                                       
                                                                    </div>
                                                                </div>
                                                            
                                                            </div>
                                                            
                                                            {block name='productdetails-matrix-classic-submit'}
                                                                {input type="hidden" name="variBox2" value="1"}
                                                                {row class="product-matrix-submit"}
                                                                    {col}
                                                                    
                                                                        {button name="indenWarenkorb"
                                                                            type="submit"
                                                                            value="{lang key='addToCart'}"
                                                                            variant="secondary"
                                                                            block=true}
                                                                            <span class="btn-basket-check">
                                                                            <i class="fas fa-shopping-cart"></i>
                                                                            <div class="shopping-cart_span">
                                                                                <span style="padding-left: 0.5rem;">
                                                                                    {lang key='addToCart'}
                                                                                </span> 
                                                                            </div>
                                                                            </span>
                                                                        {/button}
                                                                    {/col}
                                                                {/row}
                                                            {/block}
                                                        {/col}
                                                    {/col}
                                                {/block}
                                            {/if}
										{/row}
                                    {/block}
                                {/if}
                                

                                {*UPLOADS product-specific files, e.g. for customization*}
                                {block name='productdetails-details-include-uploads'}
                                    {if empty($smarty.get.quickView)}
                                     {include file="snippets/uploads.tpl" tplscope='product'}
                                    {/if}
                                {/block}
                                
                                {block name='productdetails-details-include-accordions'}
                                    <div class="accordions{if $beautekPdpV2} beautek-pdp-v2-content{/if}">

                                        {if $beautekPdpV2}
                                            {include file='snippets/beautek_pdp_v2_content.tpl' beautekPdpV2ContentPart='highlights'}
                                        {/if}

                                       
                                        

                                        {block name='productdetails-details-include-desc'}
                                            <div class="col custom-accordion" id="product-desc">
                                                <section class="panel panel-default x-supplies css-zubehoer panel-zubehoer">
                                                    <div class="panel-heading"><h4 class="panel-title">{lang key='description' section='productDetails'}</h4></div>
                                                    <div class="panel-body">
                                                    <div class="desc">
                                                        {$Artikel->cBeschreibung}
                                                            {if $useDescriptionWithMediaGroup}
                                                                {if $Artikel->cBeschreibung|strlen > 0}
                                                                    <hr>
                                                                {/if}
                                                                {foreach $Artikel->getMediaTypes() as $mediaType}
                                                                    <div class="media">
                                                                        {block name='productdetails-tabs-description-include-mediafile'}
                                                                            {include file='productdetails/mediafile.tpl'}
                                                                        {/block}
                                                                    </div>
                                                                {/foreach}
                                                            {/if}
                                                        </div>
                                                        </div>
                                                </section>
                                                <div class="svg-holder">
                                                    <svg enable-background="new 0 0 128 128" viewBox="0 0 128 128" xmlns="http://www.w3.org/2000/svg"><path id="Down_Arrow_3_" d="m64 88c-1.023 0-2.047-.391-2.828-1.172l-40-40c-1.563-1.563-1.563-4.094 0-5.656s4.094-1.563 5.656 0l37.172 37.172 37.172-37.172c1.563-1.563 4.094-1.563 5.656 0s1.563 4.094 0 5.656l-40 40c-.781.781-1.805 1.172-2.828 1.172z"></path></svg>
                                                </div>
                                            </div>
                                        {/block}

                                        {block name='productdetails-details-include-detaildata'}
                                            <div class="col custom-accordion" id="product-details">
                                                <section class="panel panel-default x-supplies css-zubehoer panel-zubehoer">
                                                    <div class="panel-heading"><h4 class="panel-title">{lang key="detailAccordion" section="custom"}</h4></div>
                                                    <div class="panel-body">
                                            
                                                    <table class="table table-sm table-striped table-bordered-outline{if $beautekPdpV2} beautek-pdp-v2-spec-table{/if}">
                                                        {if $Einstellungen.artikeldetails.merkmale_anzeigen === 'Y'}
                                                            {block name='productdetails-attributes-characteristics'}
                                                                {foreach $Artikel->oMerkmale_arr as $characteristic}
                                                                    <tr>
                                                                        <td class="h6">{$characteristic->getName()}:</td>
                                                                        <td class="attr-characteristic">
                                                                            {strip}
                                                                                {foreach $characteristic->getCharacteristicValues() as $characteristicValue}
                                                                                    {if $characteristic->getType() === 'TEXT' || $characteristic->getType() === 'SELECTBOX' || $characteristic->getType() === ''}
                                                                                        {block name='productdetails-attributes-badge'}
                                                                                            <a {if !$inQuickView}href="{$characteristicValue->getURL()}"{/if}
                                                                                            class="badge badge-primary">
                                                                                                {$characteristicValue->getValue()|escape:'html'}
                                                                                            </a>
                                                                                        {/block}
                                                                                    {else}
                                                                                        {block name='productdetails-attributes-image'}
                                                                                            <a {if !$inQuickView}href="{$characteristicValue->getURL()}"{/if}
                                                                                                class="text-decoration-none-util"
                                                                                                data-toggle="tooltip" data-placement="top" data-boundary="window"
                                                                                                title="{$characteristicValue->getValue()|escape:'html'}"
                                                                                                aria-label="{$characteristicValue->getValue()|escape:'html'}"
                                                                                            >
                                                                                                {$img = $characteristicValue->getImage(\JTL\Media\Image::SIZE_XS)}
                                                                                                {if $img !== null && strpos($img, $smarty.const.BILD_KEIN_MERKMALBILD_VORHANDEN) === false
                                                                                                && strpos($img, $smarty.const.BILD_KEIN_ARTIKELBILD_VORHANDEN) === false}
                                                                                                    {include file='snippets/image.tpl'
                                                                                                        item=$characteristicValue
                                                                                                        square=false
                                                                                                        srcSize='xs'
                                                                                                        sizes='40px'
                                                                                                        width='40'
                                                                                                        height='40'
                                                                                                        class='img-aspect-ratio'
                                                                                                        alt=$characteristicValue->getValue()}
                                                                                                {else}
                                                                                                    {badge variant="primary"}{$characteristicValue->getValue()|escape:'html'}{/badge}
                                                                                                {/if}
                                                                                            </a>
                                                                                        {/block}
                                                                                    {/if}
                                                                                {/foreach}
                                                                            {/strip}
                                                                        </td>
                                                                    </tr>
                                                                {/foreach}
                                                            {/block}
                                                        {/if}

                                                        {if $showShippingWeight}
                                                            {block name='productdetails-attributes-shipping-weight'}
                                                                <tr>
                                                                    <td class="h6">{lang key='shippingWeight'}:</td>
                                                                    <td class="weight-unit">
                                                                        {$Artikel->cGewicht} {lang key='weightUnit'}
                                                                    </td>
                                                                </tr>
                                                            {/block}
                                                        {/if}

                                                        {if $showProductWeight}
                                                            {block name='productdetails-attributes-product-weight'}
                                                                <tr class="attr-weight">
                                                                    <td class="h6">{lang key='productWeight'}:</td>
                                                                    <td class="weight-unit" itemprop="weight" itemscope itemtype="https://schema.org/QuantitativeValue">
                                                                        <span itemprop="value">{$Artikel->cArtikelgewicht}</span> <span itemprop="unitText">{lang key='weightUnit'}
                                                                    </td>
                                                                </tr>
                                                            {/block}
                                                        {/if}

                                                        {if $Einstellungen.artikeldetails.artikeldetails_inhalt_anzeigen === 'Y'
                                                            && isset($Artikel->cMasseinheitName)
                                                            && isset($Artikel->fMassMenge)
                                                            && $Artikel->fMassMenge > 0
                                                            && $Artikel->cTeilbar !== 'Y'
                                                            && ($Artikel->fAbnahmeintervall == 0 || $Artikel->fAbnahmeintervall == 1)
                                                            && isset($Artikel->cMassMenge)}
                                                            {block name='productdetails-attributes-unit'}
                                                                <tr class="attr-contents">
                                                                    <td class="h6">{lang key='contents' section='productDetails'}: </td>
                                                                    <td class="attr-value">
                                                                        {$Artikel->cMassMenge} {$Artikel->cMasseinheitName}
                                                                    </td>
                                                                </tr>
                                                            {/block}
                                                        {/if}

                                                        {if $dimension && $Einstellungen.artikeldetails.artikeldetails_abmessungen_anzeigen === 'Y'}
                                                            {block name='productdetails-attributes-dimensions'}
                                                                {assign var=dimensionArr value=$Artikel->getDimensionLocalized()}
                                                                {if $dimensionArr|count > 0}
                                                                    <tr class="attr-dimensions">
                                                                        <td class="h6">{lang key='dimensions' section='productDetails'}
                                                                            ({foreach $dimensionArr as $dimkey => $dim}
                                                                                {$dimkey}{if !$dim@last} &times; {/if}
                                                                            {/foreach}):
                                                                        </td>
                                                                        <td class="attr-value">
                                                                            {foreach $dimensionArr as $dim}
                                                                                {$dim}{if $dim@last} cm {else} &times; {/if}
                                                                            {/foreach}
                                                                        </td>
                                                                    </tr>
                                                                {/if}
                                                            {/block}
                                                        {/if}

                                                        {if $Einstellungen.artikeldetails.artikeldetails_attribute_anhaengen === 'Y'
                                                        || $Artikel->FunktionsAttribute[$smarty.const.FKT_ATTRIBUT_ATTRIBUTEANHAENGEN]|default:0 == 1}
                                                            {block name='productdetails-attributes-shop-attributes'}
                                                                {foreach $Artikel->Attribute as $Attribut}
                                                                    <tr class="attr-custom">
                                                                        <td class="h6">{$Attribut->cName}: </td>
                                                                        <td class="attr-value">{$Attribut->cWert}</td>
                                                                    </tr>
                                                                {/foreach}
                                                            {/block}
                                                        {/if}
                                                    </table>
                                                    
                                                    </div>
                                                </section>
                                                <div class="svg-holder">
                                                    <svg enable-background="new 0 0 128 128" viewBox="0 0 128 128" xmlns="http://www.w3.org/2000/svg"><path id="Down_Arrow_3_" d="m64 88c-1.023 0-2.047-.391-2.828-1.172l-40-40c-1.563-1.563-1.563-4.094 0-5.656s4.094-1.563 5.656 0l37.172 37.172 37.172-37.172c1.563-1.563 4.094-1.563 5.656 0s1.563 4.094 0 5.656l-40 40c-.781.781-1.805 1.172-2.828 1.172z"></path></svg>
                                                </div>
                                            </div>
                                        {/block}


                                        {block name='productdetails-details-include-service'}
                                            <div class="col custom-accordion" id="product-service">
                                                <section class="panel panel-default x-supplies css-zubehoer panel-zubehoer">
                                                    <div class="panel-heading"><h4 class="panel-title">{lang key="serviceAccordion" section="custom"}</h4></div>
                                                    <div class="panel-body"></div>
                                                </section>
                                                <div class="svg-holder">
                                                    <svg enable-background="new 0 0 128 128" viewBox="0 0 128 128" xmlns="http://www.w3.org/2000/svg"><path id="Down_Arrow_3_" d="m64 88c-1.023 0-2.047-.391-2.828-1.172l-40-40c-1.563-1.563-1.563-4.094 0-5.656s4.094-1.563 5.656 0l37.172 37.172 37.172-37.172c1.563-1.563 4.094-1.563 5.656 0s1.563 4.094 0 5.656l-40 40c-.781.781-1.805 1.172-2.828 1.172z"></path></svg>
                                                </div>
                                            </div>
                                        {/block}

                                        {*
                                        {block name='productdetails-details-include-reviews'}
                                            <div class="col custom-accordion" id="product-review">
                                                <section class="panel panel-default x-supplies css-zubehoer panel-zubehoer">
                                                    <div class="panel-heading"><h4 class="panel-title">{lang key="reviewAccordion" section="custom"}</h4></div>
                                                    <div class="panel-body">
                                                        {include file='productdetails/reviews.tpl' stars=$Artikel->Bewertungen->oBewertungGesamt->fDurchschnitt}
                                                    </div>
                                                </section>
                                                <div class="svg-holder">
                                                    <svg enable-background="new 0 0 128 128" viewBox="0 0 128 128" xmlns="http://www.w3.org/2000/svg"><path id="Down_Arrow_3_" d="m64 88c-1.023 0-2.047-.391-2.828-1.172l-40-40c-1.563-1.563-1.563-4.094 0-5.656s4.094-1.563 5.656 0l37.172 37.172 37.172-37.172c1.563-1.563 4.094-1.563 5.656 0s1.563 4.094 0 5.656l-40 40c-.781.781-1.805 1.172-2.828 1.172z"></path></svg>
                                                </div>
                                            </div>
                                        {/block}
                                        *}
                                        
                                    </div>

                                    {if $beautekPdpV2}
                                        {include file='snippets/beautek_pdp_v2_content.tpl' beautekPdpV2ContentPart='unsure'}
                                    {/if}
                                    
                                    <script>
                                        (function () {
                                            function initAdditionalSuppliesAccordion() {
                                                var root = document.getElementById('additional-supplies');
                                                if (!root) return;
                                                
                                                // Default: collapsed
                                                root.classList.remove('is-open');
                                                
                                                var heading = root.querySelector('.panel-heading');
                                                if (!heading) return;
                                                
                                                heading.addEventListener('click', function () {
                                                    root.classList.toggle('is-open');
                                                });
                                                
                                                heading.addEventListener('keydown', function (e) {
                                                    if (e.key === 'Enter' || e.key === ' ') {
                                                        e.preventDefault();
                                                        root.classList.toggle('is-open');
                                                    }
                                                });
                                                
                                                // Accessibility
                                                heading.setAttribute('tabindex', '0');
                                                heading.setAttribute('role', 'button');
                                            }
                                            
                                            if (document.readyState === 'loading') {
                                                document.addEventListener('DOMContentLoaded', initAdditionalSuppliesAccordion);
                                            } else {
                                                initAdditionalSuppliesAccordion();
                                            }
                                        })();
                                    </script>

                                    <div id="sticky-add-to-cart" class="sticky-add-to-cart" aria-hidden="true">
                                        <div class="sticky-add-to-cart__inner">
                                            <div class="sticky-add-to-cart__media" aria-hidden="true">
                                                {if !empty($Artikel->Bilder[0])}
                                                    {assign var=stickyAlt value=$Artikel->Bilder[0]->cAltAttribut|default:$Artikel->cName}
                                                    {image alt=$stickyAlt|truncate:60 fluid=false webp=true lazy=true
                                                        src="{$Artikel->Bilder[0]->cURLMini}"
                                                        class="sticky-add-to-cart__img"
                                                    }
                                                {/if}
                                            </div>
                                            <div class="sticky-add-to-cart__content">
                                                <div class="sticky-add-to-cart__title">
                                                    {if isset($beautekDisplayTitle) && $beautekDisplayTitle !== ''}
                                                        {$beautekDisplayTitle}
                                                    {else}
                                                        {$Artikel->cKurzbezeichnung|default:$Artikel->cName}
                                                    {/if}
                                                </div>
                                                <div class="sticky-add-to-cart__meta" aria-label="Preis">
                                                    <span class="js-sticky-price"></span>
                                                </div>
                                            </div>
                                            <button type="button" class="sticky-add-to-cart__btn js-sticky-add-to-cart">
                                                {lang key='addToCart'}
                                            </button>
                                        </div>
                                    </div>

                                    <script>
                                        (function () {
                                            function initStickyAddToCart() {
                                                var bar = document.getElementById('sticky-add-to-cart');
                                                if (!bar) return;
                                                
                                                var buyBox = document.getElementById('add-to-cart');
                                                if (!buyBox) return;
                                                
                                                var addBtn = buyBox.querySelector('button[name="inWarenkorb"], button[name="indenWarenkorb"], button[type="submit"][name="inWarenkorb"]');
                                                var priceEl = document.querySelector('.product-offer .price.h1, .product-offer .price.h2, .product-offer .price');
                                                var stickyPrice = bar.querySelector('.js-sticky-price');
                                                
                                                function syncPrice() {
                                                    if (!stickyPrice || !priceEl) return;
                                                    stickyPrice.textContent = priceEl.textContent.trim();
                                                }
                                                
                                                syncPrice();
                                                
                                                // price can change (variations/config)
                                                if (priceEl && window.MutationObserver) {
                                                    var mo = new MutationObserver(syncPrice);
                                                    mo.observe(priceEl, { childList: true, subtree: true, characterData: true });
                                                }
                                                
                                                function updateVisibility() {
                                                    var rect = buyBox.getBoundingClientRect();
                                                    var shouldShow = rect.bottom < 0; // buybox above viewport
                                                    bar.classList.toggle('is-visible', shouldShow);
                                                    bar.setAttribute('aria-hidden', shouldShow ? 'false' : 'true');
                                                    document.documentElement.classList.toggle('has-sticky-atc', shouldShow);
                                                }

                                                function computeBottomOffset() {
                                                    // Common cookie/consent banners & widgets that sit at the bottom
                                                    var selectors = [
                                                        '#CybotCookiebotDialog',
                                                        '#CookiebotWidget',
                                                        '#usercentrics-root',
                                                        '.uc-banner',
                                                        '.cc-window',
                                                        '.cookie-banner',
                                                        '.cookie-consent',
                                                        '.cookie-consent-banner',
                                                        '#cookiebanner',
                                                        '#cookie-banner',
                                                        '#cookies-banner',
                                                    ];
                                                    
                                                    var maxH = 0;
                                                    for (var i = 0; i < selectors.length; i++) {
                                                        var el = document.querySelector(selectors[i]);
                                                        if (!el) continue;
                                                        
                                                        var style = window.getComputedStyle(el);
                                                        if (style.display === 'none' || style.visibility === 'hidden' || style.opacity === '0') continue;
                                                        
                                                        // only consider fixed/sticky at bottom
                                                        if (!(style.position === 'fixed' || style.position === 'sticky')) continue;
                                                        if (style.bottom && style.bottom !== 'auto') {
                                                            var r = el.getBoundingClientRect();
                                                            // if it overlaps the bottom edge of viewport
                                                            if (r.height > 0 && r.top < window.innerHeight) {
                                                                maxH = Math.max(maxH, Math.min(r.height, window.innerHeight));
                                                            }
                                                        }
                                                    }
                                                    
                                                    document.documentElement.style.setProperty('--sticky-add-to-cart-offset', maxH + 'px');
                                                }
                                                
                                                updateVisibility();
                                                computeBottomOffset();
                                                window.addEventListener('scroll', updateVisibility, { passive: true });
                                                window.addEventListener('resize', updateVisibility);
                                                window.addEventListener('resize', computeBottomOffset);
                                                
                                                if (window.MutationObserver) {
                                                    var mo2 = new MutationObserver(function () {
                                                        computeBottomOffset();
                                                    });
                                                    mo2.observe(document.body, { childList: true, subtree: true, attributes: true });
                                                }
                                                
                                                var stickyBtn = bar.querySelector('.js-sticky-add-to-cart');
                                                if (stickyBtn && addBtn) {
                                                    stickyBtn.addEventListener('click', function () {
                                                        addBtn.click();
                                                    });
                                                }
                                            }
                                            
                                            if (document.readyState === 'loading') {
                                                document.addEventListener('DOMContentLoaded', initStickyAddToCart);
                                            } else {
                                                initStickyAddToCart();
                                            }
                                        })();
                                    </script>
                                {/block}


                                {*WARENKORB anzeigen wenn keine variationen mehr auf lager sind?!*}
                                {if $Artikel->bHasKonfig}

                                    {block name='productdetails-details-include-config-container-popup'}
                                        {if $Einstellungen.template.productdetails.config_position === 'popup'}
                                            {row id="product-configurator" class="cfg-position-{$Einstellungen.template.productdetails.config_position} cfg-layout-{$Einstellungen.template.productdetails.config_layout}"}
												{include file='productdetails/config_container.tpl'}
											{/row}
										{/if}
                                    {/block}
                                {else}
                                    {if $Artikel->nIstVater && $Artikel->kVaterArtikel == 0}
                                        {if empty($smarty.get.quickView)}
                                             {include file='productdetails/basket.tpl'}
                                        {/if}
                                    {/if}
                                    {if $Artikel->bHasKonfig != true}

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
    
                                                    <div id="cstmPayPal" class="cstm-contact-banner">
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
																	<h4  class="btc_sub_section-title">Ich bin gerne für dich da!</h4>
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

                                    {block name="productdetails-details-trustelements"}
                                    <div class="trust-elements-wrap">
                                        <div class="rezensionen">
                                            <div class="banner-bottom-img">
                                                <img src="/templates/NOVAChild/themes/base/images/GoogleBewertungSterne.svg" class="google-svg" alt="Unsere Google Bewertungen" />
                                            </div>
                                        </div>
                                        <div class="trust-elements">
                                            <div class="img-holder">
                                                <img src="/bilder/kk_dropper_uploads/Icon_USP83.png" />
                                                <span>{lang key="trustPayment" section="custom"}</span>
                                            </div>
                                            <div class="img-holder">
                                                <img src="/bilder/kk_dropper_uploads/Icon_USP210.png" />
                                                <span>{lang key="trustContact" section="custom"}</span>
                                            </div>
                                            <div class="img-holder">
                                                <img src="/bilder/kk_dropper_uploads/Icon_USP348.png" />
                                                <span>{lang key="trustAllInOne" section="custom"}</span>
                                            </div>
                                            <div class="img-holder">
                                                <img src="/bilder/kk_dropper_uploads/Icon_USP490.png" />
                                                <span>{lang key="trustExp" section="custom"}</span>
                                            </div>
                                        </div>
                                    </div>
                                    {/block}

                                {/if}
                            </div>
                        
                        {/block}{* productdetails-info *}
                        {opcMountPoint id='opc_after_product_info'}
                    {/col}	
					
					{block name='productdetails-details-include-config-container-details'}
						{if $Artikel->bHasKonfig && $Einstellungen.template.productdetails.config_position === 'details'}
							{col cols=12 id="product-configurator" class="cfg-position-{$Einstellungen.template.productdetails.config_position} cfg-layout-{$Einstellungen.template.productdetails.config_layout}"}
								{include file='productdetails/config_container.tpl'}
							{/col}
						{/if}
					{/block}
                {/row}
				
                {block name='productdetails-details-include-matrix'}
                    {include file='productdetails/matrix.tpl'}
                {/block}
            {/form}
        {/container}
    {/block}

    {block name='productdetails-details-content-not-quickview'}
        {block name='productdetails-details-include-tabs'}
            {include file='productdetails/tabs.tpl'}
        {/block}

        {*SLIDERS*}
         {if isset($Einstellungen.artikeldetails.artikeldetails_stueckliste_anzeigen) && $Einstellungen.artikeldetails.artikeldetails_stueckliste_anzeigen === 'Y' && isset($Artikel->oStueckliste_arr) && $Artikel->oStueckliste_arr|count > 0
        || isset($Einstellungen.artikeldetails.artikeldetails_produktbundle_nutzen) && $Einstellungen.artikeldetails.artikeldetails_produktbundle_nutzen === 'Y' && isset($Artikel->oProduktBundle_arr) && $Artikel->oProduktBundle_arr|count > 0
        || isset($Xselling->Standard->XSellGruppen) && count($Xselling->Standard->XSellGruppen) > 0
        || isset($Xselling->Kauf->Artikel) && count($Xselling->Kauf->Artikel) > 0
        || isset($oAehnlicheArtikel_arr) && count($oAehnlicheArtikel_arr) > 0}
            {container fluid=true class="{if $Einstellungen.template.theme.left_sidebar === 'Y' && $boxesLeftActive}container-plus-sidebar{/if}"}
                {if isset($Einstellungen.artikeldetails.artikeldetails_stueckliste_anzeigen) && $Einstellungen.artikeldetails.artikeldetails_stueckliste_anzeigen === 'Y' && isset($Artikel->oStueckliste_arr) && $Artikel->oStueckliste_arr|count > 0}
                    {block name='productdetails-details-include-product-slider-partslist'}
                        <div class="partslist">
                            {lang key='listOfItems' section='global' assign='slidertitle'}
                            {include file='snippets/product_slider.tpl' id='slider-partslist' productlist=$Artikel->oStueckliste_arr title=$slidertitle showPartsList=true}
                        </div>
                    {/block}
                {/if}

                {if isset($Einstellungen.artikeldetails.artikeldetails_produktbundle_nutzen) && $Einstellungen.artikeldetails.artikeldetails_produktbundle_nutzen === 'Y' && isset($Artikel->oProduktBundle_arr) && $Artikel->oProduktBundle_arr|count > 0}
                    {block name='productdetails-details-include-bundle'}
                        <div class="bundle">
                            {include file='productdetails/bundle.tpl' ProductKey=$Artikel->kArtikel Products=$Artikel->oProduktBundle_arr ProduktBundle=$Artikel->oProduktBundlePrice ProductMain=$Artikel->oProduktBundleMain}
                        </div>
                    {/block}
                {/if}
                {if isset($Xselling->Standard) || isset($Xselling->Kauf) || isset($oAehnlicheArtikel_arr)}
                    <div class="recommendations d-print-none">
                        {block name='productdetails-details-recommendations'}

                            {*
                            {if isset($Xselling->Standard->XSellGruppen) && count($Xselling->Standard->XSellGruppen) > 0}
                                {foreach $Xselling->Standard->XSellGruppen as $Gruppe}
                                    {include file='snippets/product_slider.tpl' class='x-supplies' id='slider-xsell-group-'|cat:$Gruppe@iteration productlist=$Gruppe->Artikel title=$Gruppe->Name}
                                {/foreach}
                            {/if}

                            {if isset($Xselling->Kauf->Artikel) && count($Xselling->Kauf->Artikel) > 0}
                                {lang key='customerWhoBoughtXBoughtAlsoY' section='productDetails' assign='slidertitle'}
                                {include file='snippets/product_slider.tpl' class='x-sell' id='slider-xsell' productlist=$Xselling->Kauf->Artikel title=$slidertitle}
                            {/if}
                            *}

                            {if isset($oAehnlicheArtikel_arr) && count($oAehnlicheArtikel_arr) > 0}
                                {lang key='RelatedProducts' section='productDetails' assign='slidertitle'}
                                {include file='snippets/product_slider.tpl' class='x-related' id='slider-related' productlist=$oAehnlicheArtikel_arr title=$slidertitle}
                            {/if}
                        {/block}
                    </div>
                {/if}
            {/container}
        {/if}
        {block name='productdetails-details-include-popups'}
            <div id="article_popups">
                {include file='productdetails/popups.tpl'}
            </div>
        {/block}
    {/block}
{/block}
