{extends file="{$parent_template_path}/productlist/item_slider.tpl"}

{*
  Beautek: Direkter "In den Warenkorb"-Button für die Cross-Selling-Kacheln
  im Warenkorb ("Nützliches zum mitbestellen" / "Sets zum Sparpreis").

  - Nur auf der Warenkorbseite (PAGE_WARENKORB), damit Slider auf anderen
    Seiten (Produktdetail, Startseite) unverändert bleiben.
  - Nur für direkt kaufbare Artikel (keine Variations-/Konfigartikel). Für
    alle anderen Fälle erscheint ein "Details"-Button (kein Direktkauf, da
    dort eine Auswahl nötig ist).
  - Nutzt JTLs AJAX-Warenkorb (data-toggle="basket-add"), genau wie die
    Standard-Produktlisten.
*}
{block name='productlist-item-slider-include-price'}
    {$smarty.block.parent}

    {if isset($nSeitenTyp) && $nSeitenTyp === $smarty.const.PAGE_WARENKORB}
        {$beautekBuyable = (isset($Artikel->inWarenkorbLegbar) && $Artikel->inWarenkorbLegbar === 1
            && ($Artikel->nIstVater|default:0) == 0
            && (empty($Artikel->Variationen) || $Artikel->Variationen|count === 0)
            && empty($Artikel->bHasKonfig))}

        <div class="beautek-xsell-add">
            {if $beautekBuyable}
                {form id="beautek_xsell_form_{$Artikel->kArtikel}"
                    action=$ShopURL
                    method="post"
                    class="form form-basket jtl-validate"
                    data=["toggle" => "basket-add"]}
                    {input type="hidden" name="a" value=$Artikel->kArtikel}
                    {input type="hidden" name="wke" value="1"}
                    {input type="hidden" name="anzahl" value="1"}
                    {button type="submit"
                        variant="primary"
                        block=true
                        class="basket-details-add-to-cart beautek-xsell-add-btn"
                        title="{lang key='addToCart'}"
                        aria=["label"=>{lang key='addToCart'}]}
                        {lang key='addToCart'}
                    {/button}
                {/form}
            {else}
                {link class="btn btn-outline-primary btn-block beautek-xsell-details-btn"
                    role="button"
                    href=$Artikel->cURLFull}
                    {lang key='details'}
                {/link}
            {/if}
        </div>
    {/if}
{/block}
