{*
  Beautek PDP v2 – Content unter der Buy-Box
  Parameter $beautekPdpV2ContentPart: highlights | unsure

  Highlights:
  1) Funktionsattribut „beautek_highlights“ (optional, kuratiert)
  2) sonst Merkmale aus dem System (wie bisher)
*}
{if !isset($beautekPdpV2ContentPart)}
    {$beautekPdpV2ContentPart = 'highlights'}
{/if}

{if $beautekPdpV2 && empty($smarty.get.quickView)}

    {if $beautekPdpV2ContentPart === 'highlights'}
        {$beautekHasCustomHl = isset($Artikel->FunktionsAttribute['beautek_highlights']) && $Artikel->FunktionsAttribute['beautek_highlights']|trim !== ''}
        {$beautekHasMerkmale = $Einstellungen.artikeldetails.merkmale_anzeigen === 'Y' && $Artikel->oMerkmale_arr|@count > 0}

        {if $beautekHasCustomHl || $beautekHasMerkmale}
            <section class="beautek-pdp-v2-section beautek-pdp-v2-highlights">
                <p class="beautek-pdp-v2-kicker">Ausstattung</p>
                <h2 class="beautek-pdp-v2-heading">Highlights</h2>
                <ul class="beautek-pdp-v2-feature-list">
                    {if $beautekHasCustomHl}
                        {$beautekHlRaw = $Artikel->FunktionsAttribute['beautek_highlights']|trim|replace:"\r\n":"\n"|replace:"\r":"\n"}
                        {$beautekHlLines = "\n"|explode:$beautekHlRaw}
                        {foreach $beautekHlLines as $beautekHlLine}
                            {$beautekHlLine = $beautekHlLine|trim}
                            {if $beautekHlLine !== ''}
                                {$beautekHlParts = '|'|explode:$beautekHlLine}
                                {if $beautekHlParts|@count < 2}
                                    {$beautekHlParts = ' – '|explode:$beautekHlLine}
                                {/if}
                                {$beautekHlTitle = $beautekHlParts[0]|trim}
                                {$beautekHlDesc = ''}
                                {if $beautekHlParts|@count > 1}
                                    {$beautekHlDesc = $beautekHlParts[1]|trim}
                                {/if}
                                <li>
                                    <span class="beautek-pdp-v2-feature-mark" aria-hidden="true">✓</span>
                                    <span>
                                        <strong>{$beautekHlTitle}</strong>
                                        {if $beautekHlDesc !== ''}
                                            <span class="beautek-pdp-v2-feature-val">{$beautekHlDesc}</span>
                                        {/if}
                                    </span>
                                </li>
                            {/if}
                        {/foreach}
                    {else}
                        {foreach $Artikel->oMerkmale_arr as $characteristic name=beautekHl}
                            {if $smarty.foreach.beautekHl.iteration <= 8}
                                {$beautekHlVals = ''}
                                {foreach $characteristic->getCharacteristicValues() as $characteristicValue}
                                    {if $beautekHlVals !== ''}{$beautekHlVals = $beautekHlVals|cat:', '}{/if}
                                    {$beautekHlVals = $beautekHlVals|cat:$characteristicValue->getValue()}
                                {/foreach}
                                <li>
                                    <span class="beautek-pdp-v2-feature-mark" aria-hidden="true">✓</span>
                                    <span>
                                        <strong>{$characteristic->getName()}</strong>
                                        {if $beautekHlVals !== ''}
                                            <span class="beautek-pdp-v2-feature-val">{$beautekHlVals}</span>
                                        {/if}
                                    </span>
                                </li>
                            {/if}
                        {/foreach}
                    {/if}
                </ul>
            </section>
        {/if}
    {/if}

    {if $beautekPdpV2ContentPart === 'unsure'}
        <aside class="beautek-pdp-v2-unsure">
            <div class="beautek-pdp-v2-unsure-text">
                <h2 class="beautek-pdp-v2-heading">Noch Fragen?</h2>
                <p>Marie-Teresa berät dich persönlich – per Telefon. Mo–Fr 8:30–16:30.</p>
            </div>
            <a class="beautek-pdp-v2-unsure-btn" href="tel:+492713137430">Kostenlose Beratung</a>
        </aside>
    {/if}

{/if}
