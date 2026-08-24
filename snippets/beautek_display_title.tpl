{*
  Beautek Anzeigetitel aus Artikel ableiten (ohne Wawi zu ändern).
  Setzt lokal: $beautekCardTitle, $beautekCardSubtitle

  Quelle: Funktionsattribut beautek_anzeigetitel / beautek_unterzeile
       sonst Split von cName (Fallback: cKurzbezeichnung) an „ I “ / „ | “
*}
{if isset($Artikel->FunktionsAttribute['beautek_anzeigetitel']) && $Artikel->FunktionsAttribute['beautek_anzeigetitel'] !== ''}
    {$beautekCardTitle = $Artikel->FunktionsAttribute['beautek_anzeigetitel']}
    {$beautekCardSubtitle = $Artikel->FunktionsAttribute['beautek_unterzeile']|default:''}
{else}
    {$beautekTitleSource = $Artikel->cName|default:$Artikel->cKurzbezeichnung}
    {$beautekNormName = $beautekTitleSource|replace:' I ':'|'|replace:' | ':'|'}
    {$beautekTitleParts = '|'|explode:$beautekNormName}
    {$beautekCardTitle = $beautekTitleParts[0]|trim}
    {$beautekCardSubtitle = ''}
    {if $beautekTitleParts|@count > 1}
        {foreach from=$beautekTitleParts item=beautekPart name=beautekCardTitleLoop}
            {if !$smarty.foreach.beautekCardTitleLoop.first}
                {if $beautekCardSubtitle !== ''}{$beautekCardSubtitle = $beautekCardSubtitle|cat:' · '}{/if}
                {$beautekCardSubtitle = $beautekCardSubtitle|cat:($beautekPart|trim)}
            {/if}
        {/foreach}
    {/if}
{/if}
