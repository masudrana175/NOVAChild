{*
  Beautek Kategorie-Karte Meta (live)
  Echte Farb-Swatches (nur wenn sinnvoll).
  Bilder als einfaches <img> – kein square/lazy-Wrapper (sonst leere Kreise).
*}
{if empty($smarty.get.quickView)}

    {$beautekSwatchVariation = null}
    {if isset($Artikel->Variationen) && $Artikel->Variationen|@count > 0}
        {foreach $Artikel->Variationen as $beautekVar}
            {if $beautekSwatchVariation === null && $beautekVar->Werte|@count > 1}
                {$beautekVarName = $beautekVar->cName|lower}
                {if $beautekVarName|strstr:'polster'
                    || $beautekVarName|strstr:'farbe'
                    || $beautekVarName|strstr:'color'
                    || $beautekVarName|strstr:'colour'}
                    {$beautekSwatchVariation = $beautekVar}
                {/if}
            {/if}
        {/foreach}
    {/if}

    {if $beautekSwatchVariation !== null}
        {$beautekUsableSwatches = 0}
        {foreach $beautekSwatchVariation->Werte as $beautekSwatchVal}
            {$beautekSwatchImg = $beautekSwatchVal->getImage(\JTL\Media\Image::SIZE_XS)}
            {$beautekHasImg = false}
            {if !empty($beautekSwatchImg)
                && !($beautekSwatchImg|strstr:$smarty.const.BILD_KEIN_ARTIKELBILD_VORHANDEN)
                && !($beautekSwatchImg|strstr:'keinBild')}
                {$beautekHasImg = true}
            {/if}
            {$beautekColorHint = $beautekSwatchVal->cName|lower}
            {$beautekColorClass = ''}
            {if $beautekColorHint|strstr:'dunkelgrau' || $beautekColorHint|strstr:'anthrazit'}
                {$beautekColorClass = 'is-dunkelgrau'}
            {elseif $beautekColorHint|strstr:'grau' || $beautekColorHint|strstr:'gray' || $beautekColorHint|strstr:'grey'}
                {$beautekColorClass = 'is-grau'}
            {elseif $beautekColorHint|strstr:'schwarz' || $beautekColorHint|strstr:'black'}
                {$beautekColorClass = 'is-schwarz'}
            {elseif $beautekColorHint|strstr:'weiß' || $beautekColorHint|strstr:'weiss' || $beautekColorHint|strstr:'white'}
                {$beautekColorClass = 'is-white'}
            {elseif $beautekColorHint|strstr:'beige' || $beautekColorHint|strstr:'creme' || $beautekColorHint|strstr:'sand' || $beautekColorHint|strstr:'braun' || $beautekColorHint|strstr:'taupe'}
                {$beautekColorClass = 'is-beige'}
            {elseif $beautekColorHint|strstr:'blau' || $beautekColorHint|strstr:'navy' || $beautekColorHint|strstr:'türkis' || $beautekColorHint|strstr:'tuerkis'}
                {$beautekColorClass = 'is-blau'}
            {elseif $beautekColorHint|strstr:'rot' || $beautekColorHint|strstr:'pink' || $beautekColorHint|strstr:'bordeaux'}
                {$beautekColorClass = 'is-rot'}
            {elseif $beautekColorHint|strstr:'grün' || $beautekColorHint|strstr:'gruen' || $beautekColorHint|strstr:'olive'}
                {$beautekColorClass = 'is-gruen'}
            {elseif $beautekColorHint|strstr:'lila' || $beautekColorHint|strstr:'violett' || $beautekColorHint|strstr:'purple'}
                {$beautekColorClass = 'is-lila'}
            {elseif $beautekColorHint|strstr:'gelb' || $beautekColorHint|strstr:'orange' || $beautekColorHint|strstr:'senf'}
                {$beautekColorClass = 'is-gelb'}
            {/if}
            {if $beautekHasImg || $beautekColorClass !== ''}
                {$beautekUsableSwatches = $beautekUsableSwatches + 1}
            {/if}
        {/foreach}

        {if $beautekUsableSwatches > 1}
            <div class="beautek-productbox-swatches" aria-label="{$beautekSwatchVariation->cName|escape:'html'}">
                {$beautekSwatchShown = 0}
                {foreach $beautekSwatchVariation->Werte as $beautekSwatchVal}
                    {if $beautekSwatchShown < 4}
                        {$beautekSwatchImg = $beautekSwatchVal->getImage(\JTL\Media\Image::SIZE_XS)}
                        {$beautekHasImg = false}
                        {if !empty($beautekSwatchImg)
                            && !($beautekSwatchImg|strstr:$smarty.const.BILD_KEIN_ARTIKELBILD_VORHANDEN)
                            && !($beautekSwatchImg|strstr:'keinBild')}
                            {$beautekHasImg = true}
                        {/if}
                        {$beautekColorHint = $beautekSwatchVal->cName|lower}
                        {$beautekColorClass = ''}
                        {if $beautekColorHint|strstr:'dunkelgrau' || $beautekColorHint|strstr:'anthrazit'}
                            {$beautekColorClass = 'is-dunkelgrau'}
                        {elseif $beautekColorHint|strstr:'grau' || $beautekColorHint|strstr:'gray' || $beautekColorHint|strstr:'grey'}
                            {$beautekColorClass = 'is-grau'}
                        {elseif $beautekColorHint|strstr:'schwarz' || $beautekColorHint|strstr:'black'}
                            {$beautekColorClass = 'is-schwarz'}
                        {elseif $beautekColorHint|strstr:'weiß' || $beautekColorHint|strstr:'weiss' || $beautekColorHint|strstr:'white'}
                            {$beautekColorClass = 'is-white'}
                        {elseif $beautekColorHint|strstr:'beige' || $beautekColorHint|strstr:'creme' || $beautekColorHint|strstr:'sand' || $beautekColorHint|strstr:'braun' || $beautekColorHint|strstr:'taupe'}
                            {$beautekColorClass = 'is-beige'}
                        {elseif $beautekColorHint|strstr:'blau' || $beautekColorHint|strstr:'navy' || $beautekColorHint|strstr:'türkis' || $beautekColorHint|strstr:'tuerkis'}
                            {$beautekColorClass = 'is-blau'}
                        {elseif $beautekColorHint|strstr:'rot' || $beautekColorHint|strstr:'pink' || $beautekColorHint|strstr:'bordeaux'}
                            {$beautekColorClass = 'is-rot'}
                        {elseif $beautekColorHint|strstr:'grün' || $beautekColorHint|strstr:'gruen' || $beautekColorHint|strstr:'olive'}
                            {$beautekColorClass = 'is-gruen'}
                        {elseif $beautekColorHint|strstr:'lila' || $beautekColorHint|strstr:'violett' || $beautekColorHint|strstr:'purple'}
                            {$beautekColorClass = 'is-lila'}
                        {elseif $beautekColorHint|strstr:'gelb' || $beautekColorHint|strstr:'orange' || $beautekColorHint|strstr:'senf'}
                            {$beautekColorClass = 'is-gelb'}
                        {/if}
                        {if $beautekHasImg || $beautekColorClass !== ''}
                            <a class="beautek-productbox-swatch{if $beautekHasImg} has-image{/if}{if $beautekColorClass !== ''} {$beautekColorClass}{/if}"
                               href="{$Artikel->cURLFull}"
                               title="{$beautekSwatchVal->cName|escape:'html'}"
                               data-color-name="{$beautekSwatchVal->cName|escape:'html'}">
                                {if $beautekHasImg}
                                    <img class="beautek-productbox-swatch-img"
                                         src="{$beautekSwatchImg}"
                                         alt="{$beautekSwatchVal->cName|escape:'html'}"
                                         width="28"
                                         height="28"
                                         loading="lazy"
                                         decoding="async">
                                {/if}
                            </a>
                            {$beautekSwatchShown = $beautekSwatchShown + 1}
                        {/if}
                    {/if}
                {/foreach}
                {if $beautekUsableSwatches > 4}
                    <span class="beautek-productbox-swatch-more">+{$beautekUsableSwatches - 4}</span>
                {/if}
            </div>
        {/if}
    {/if}

{/if}
