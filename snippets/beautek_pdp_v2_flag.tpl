{*
  Beautek PDP v2 Preview-Flag
  ------------------------------------------------------------------
  Aktivieren:   …/artikelurl?v=pdp2     (setzt Cookie 30 Tage)
  Deaktivieren: …/artikelurl?v=off      (löscht Cookie)

  Nutzung: {if $beautekPdpV2}…{/if}
  Body-Klasse: beautek-pdp-v2

  Parameter $beautekPdpV2EmitCookie (optional):
    true  → Cookie-Script ausgeben (nach <body>)
    false → nur Variable setzen (vor <body>)
*}

{if !isset($beautekPdpV2EmitCookie)}
    {$beautekPdpV2EmitCookie = false}
{/if}

{assign var='beautekPdpV2' value=false scope='global'}

{if isset($smarty.get.v)}
    {if $smarty.get.v === 'pdp2'}
        {assign var='beautekPdpV2' value=true scope='global'}
    {elseif $smarty.get.v === 'off'}
        {assign var='beautekPdpV2' value=false scope='global'}
    {elseif $smarty.get.v === 'cfg'}
        {* anderes Preview-Kürzel: PDP-v2-Cookie unverändert lassen *}
        {if isset($smarty.cookies.beautek_pdp_v2) && $smarty.cookies.beautek_pdp_v2 == '1'}
            {assign var='beautekPdpV2' value=true scope='global'}
        {/if}
    {else}
        {assign var='beautekPdpV2' value=false scope='global'}
    {/if}
{elseif isset($smarty.cookies.beautek_pdp_v2) && $smarty.cookies.beautek_pdp_v2 == '1'}
    {assign var='beautekPdpV2' value=true scope='global'}
{/if}

{if $beautekPdpV2EmitCookie && isset($smarty.get.v)}
<script>
(function () {
    try {
        var v = '{$smarty.get.v|escape:'javascript'}';
        if (v === 'pdp2') {
            document.cookie = 'beautek_pdp_v2=1;path=/;max-age=2592000;SameSite=Lax';
        } else if (v === 'off') {
            document.cookie = 'beautek_pdp_v2=;path=/;max-age=0;SameSite=Lax';
        }
    } catch (e) {}
})();
</script>
{/if}
