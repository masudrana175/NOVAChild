{block name='productlist-item-box'}
    {* Absolute Produkt-URL (manche Artikel liefern nur relative cURL/cURLFull) *}
    {if !empty($Artikel->cURLFull) && !($Artikel->cURLFull|strpos:'http' !== 0)}
        {$productHref = $Artikel->cURLFull}
    {elseif !empty($Artikel->cURLFull) && !($Artikel->cURLFull|strpos:'/' !== 0)}
        {$productHref = rtrim($ShopURL, '/')|cat:$Artikel->cURLFull}
    {elseif !empty($Artikel->cURLFull)}
        {$productHref = rtrim($ShopURL, '/')|cat:'/'|cat:$Artikel->cURLFull}
    {elseif !empty($Artikel->cURL) && !($Artikel->cURL|strpos:'http' !== 0)}
        {$productHref = $Artikel->cURL}
    {elseif !empty($Artikel->cURL)}
        {$productHref = rtrim($ShopURL, '/')|cat:'/'|cat:$Artikel->cURL}
    {else}
        {$productHref = '#'}
    {/if}
    {if $Einstellungen.template.productlist.variation_select_productlist_gallery === 'N'}
        {assign var=hasOnlyListableVariations value=0}
		{$showVariationCollapse = false}
    {else}
        {hasOnlyListableVariations artikel=$Artikel            axVariationCount=$Einstellungen.template.productlist.variation_select_productlist_gallery
		maxWerteCount=$Einstellungen.template.productlist.variation_max_werte_productlist_gallery
        assign='hasOnlyListableVariations'}
		{$showVariationCollapse = ($hasOnlyListableVariations > 0 && $Artikel->nIstVater && !$Artikel->bHasKonfig && $Artikel->kEigenschaftKombi === 0 &&
        empty($Artikel->FunktionsAttribute[\FKT_ATTRIBUT_NO_GAL_VAR_PREVIEW]) &&
		$Artikel->nVariationOhneFreifeldAnzahl <= 2 &&
		($Artikel->Variationen[0]->cTyp === 'IMGSWATCHES' || $Artikel->Variationen[0]->cTyp === 'TEXTSWATCHES' || $Artikel->Variationen[0]->cTyp === 'SELECTBOX') &&
		(!isset($Artikel->Variationen[1]) || ($Artikel->Variationen[1]->cTyp === 'IMGSWATCHES' || $Artikel->Variationen[1]->cTyp === 'TEXTSWATCHES' || $Artikel->Variationen[1]->cTyp === 'SELECTBOX')))}	
    {/if}
    {if $Artikel->kArtikel|default:FALSE}
    <div id="{$idPrefix|default:''}result-wrapper_buy_form_{$Artikel->kArtikel}" data-wrapper="true"
         class="productbox productbox-column {if !empty($hasOnlyListableVariations) && empty($Artikel->FunktionsAttribute[\FKT_ATTRIBUT_NO_GAL_VAR_PREVIEW])}productbox-show-variations {/if} productbox-hover{if isset($class)} {$class}{/if} {if $showVariationCollapse}show-variation-collapse{/if}">
        {block name='productlist-item-box-include-productlist-actions'}
            <div class="productbox-quick-actions productbox-onhover d-none d-md-flex">
                {include file='productlist/productlist_actions.tpl'}
            </div>
        {/block}

        {form id="{$idPrefix|default:''}buy_form_{$Artikel->kArtikel}"
        action=$ShopURL class="form form-basket jtl-validate"
        data=["toggle" => "basket-add"]}
        {input type="hidden" name="a" value="{if !empty({$Artikel->kVariKindArtikel})}{$Artikel->kVariKindArtikel}{else}{$Artikel->kArtikel}{/if}"}
        <div class="productbox-inner">
            {row}
                {col cols=12}
                    <div class="productbox-image" data-target="#variations-collapse-{$Artikel->kArtikel}">
                        {if isset($Artikel->Bilder[0]->cAltAttribut)}
                            {assign var=alt value=$Artikel->Bilder[0]->cAltAttribut}
                        {else}
                            {assign var=alt value=$Artikel->cName}
                        {/if}
                        {block name='productlist-item-box-image'}
                            {counter assign=imgcounter print=0}
                                {block name='productlist-item-box-include-ribbon'}
                                    {include file='snippets/ribbon.tpl'}
                                {/block}
                            <div class="productbox-images list-gallery">
                                {link href=$productHref}
                                    {block name="productlist-item-list-image"}
                                        {strip}
                                            {$image = $Artikel->Bilder[0]}
                                            <div class="productbox-image square square-image first-wrapper">
                                                <div class="inner">
                                            {image alt=$alt|truncate:60 fluid=true webp=true lazy=true
                                                src="{$image->cURLKlein}"
                                                srcset="
                                                            {$image->cURLMini} {$image->imageSizes->xs->size->width}w,
                                                            {$image->cURLKlein} {$image->imageSizes->sm->size->width}w,
                                                            {$image->cURLNormal} {$image->imageSizes->md->size->width}w"
                                                        sizes = '(min-width: 1300px) 25vw, (min-width: 992px) 34vw, 50vw'
                                                data=["id"  => $imgcounter]
                                                class="{if !$isMobile && !empty($Artikel->Bilder[1])} first{/if}"
                                                fluid=true
                                              }
                                                </div>
                                            </div>
                                            {if !$isMobile && !empty($Artikel->Bilder[1])}
                                                <div class="productbox-image square square-image second-wrapper">
                                                    <div class="inner">
                                                    {$image = $Artikel->Bilder[1]}
                                                    {if isset($image->cAltAttribut)}
                                                        {$alt=$image->cAltAttribut}
                                                    {else}
                                                        {$alt=$Artikel->cName}
                                                    {/if}
                                                    {image alt=$alt|truncate:60 fluid=true webp=true lazy=true
                                                        src="{$image->cURLKlein}"
                                                        srcset="
                                                            {$image->cURLMini} {$image->imageSizes->xs->size->width}w,
                                                            {$image->cURLKlein} {$image->imageSizes->sm->size->width}w,
                                                            {$image->cURLNormal} {$image->imageSizes->md->size->width}w"
                                                        sizes = '(min-width: 1300px) 25vw, (min-width: 992px) 34vw, 50vw'
                                                        data=["id"  => $imgcounter|cat:"_2nd"]
                                                        class='second'
                                                    }
                                                </div>
                                            </div>
                                            {/if}
                                        {/strip}
                                    {/block}
                                {/link}
                                {if !empty($Artikel->Bilder[0]->cURLNormal)}
                                    <meta itemprop="image" content="{$Artikel->Bilder[0]->cURLNormal}">
                                {/if}
							</div>
                            {include file='snippets/beauty_summer_special_badge.tpl'}
                            {include file='snippets/summer_sale_badge.tpl'}
						{/block}
                    </div>
				{/col}
				{if $showVariationCollapse}
                    {col cols=12 class='productbox-variations'}
						{block name='productlist-item-box-form-variations'}
							<div class="productbox-onhover collapse" id="variations-collapse-{$Artikel->kArtikel}">
								{block name='productlist-item-box-form-include-variation'}
									{include file='productlist/variation_gallery.tpl'
									simple=$Artikel->isSimpleVariation showMatrix=false
									smallView=true ohneFreifeld=($hasOnlyListableVariations == 2)}
								{/block}						
							</div>
						{/block}
					{/col}
				 {/if}
                {col cols=12}
                    {block name='productlist-item-box-caption'}
                        {block name='productlist-item-box-caption-short-desc'}
                            <div class="productbox-title beautek-productbox-title js-beautek-card-title" itemprop="name">
                                {link href=$productHref
                                    class="text-clamp-2"
                                    data=["full-name"=>$Artikel->cName]}
                                    {$Artikel->cKurzbezeichnung}
                                {/link}
                            </div>
                            {include file='snippets/beautek_productbox_meta.tpl'}
                        {/block}
                        {block name='productlist-item-box-meta'}
                            {if $Artikel->cName !== $Artikel->cKurzbezeichnung}
                                <meta itemprop="alternateName" content="{$Artikel->cName}">
                            {/if}
                            <meta itemprop="url" content="{$productHref}">
                        {/block}
                        {block name='productlist-index-include-rating'}
                            {* Sterne auf Kategorie-Karten bewusst ausgeblendet *}
                        {/block}
                        {block name='productlist-index-include-price'}
                            <div itemprop="offers" itemscope itemtype="https://schema.org/Offer">
                                <link itemprop="businessFunction" href="http://purl.org/goodrelations/v1#Sell" />
                                {include file='productdetails/price.tpl' Artikel=$Artikel tplscope=$tplscope}
                                <div class="beautek-productbox-avail">
                                    {if isset($Artikel->fLagerbestand) && $Artikel->fLagerbestand > 0}
                                        <span class="is-ready"
                                              title="{if !empty($Artikel->cEstimatedDelivery)}Lieferzeit: {$Artikel->cEstimatedDelivery|escape:'html'}{else}Sofort versandfertig{/if}">
                                            Schnell bei dir
                                        </span>
                                    {elseif !empty($Artikel->cEstimatedDelivery)}
                                        {$beautekDeliveryRaw = $Artikel->cEstimatedDelivery|lower}
                                        {if $beautekDeliveryRaw|strstr:'woche'}
                                            <span class="is-long" title="Lieferzeit: {$Artikel->cEstimatedDelivery|escape:'html'}">
                                                Etwas längere Lieferzeit
                                            </span>
                                        {else}
                                            <span class="is-soon" title="Lieferzeit: {$Artikel->cEstimatedDelivery|escape:'html'}">
                                                Lieferung in wenigen Tagen
                                            </span>
                                        {/if}
                                    {/if}
                                </div>
                            </div>
                        {/block}
                    {/block}
                {/col}
            {/row}
        </div>
		{/form}
    </div>
	{/if}
{/block}
