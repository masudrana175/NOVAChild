{*
  Beautek Konfigurator-Pills Preview-Flag
  ------------------------------------------------------------------
  Aktivieren:   …/artikelurl?v=cfg     (setzt Cookie 30 Tage)
  Deaktivieren: …/artikelurl?v=off     (löscht Cookie)

  Nutzung: {if $beautekCfgPills}…{/if}
  Body-Klasse: beautek-cfg-pills

  Parameter $beautekCfgPillsEmitCookie (optional):
    true  → Cookie-Script ausgeben (nach <body>)
    false → nur Variable setzen (vor <body>)
*}

{if !isset($beautekCfgPillsEmitCookie)}
    {$beautekCfgPillsEmitCookie = false}
{/if}

{assign var='beautekCfgPills' value=false scope='global'}

{if isset($smarty.get.v)}
    {if $smarty.get.v === 'cfg'}
        {assign var='beautekCfgPills' value=true scope='global'}
    {elseif $smarty.get.v === 'off'}
        {assign var='beautekCfgPills' value=false scope='global'}
    {elseif isset($smarty.cookies.beautek_cfg_pills) && $smarty.cookies.beautek_cfg_pills == '1'}
        {* anderes ?v=… (z. B. pdp2): Cookie-Status behalten *}
        {assign var='beautekCfgPills' value=true scope='global'}
    {/if}
{elseif isset($smarty.cookies.beautek_cfg_pills) && $smarty.cookies.beautek_cfg_pills == '1'}
    {assign var='beautekCfgPills' value=true scope='global'}
{/if}

{if $beautekCfgPillsEmitCookie && isset($smarty.get.v)}
<script>
(function () {
    try {
        var v = '{$smarty.get.v|escape:'javascript'}';
        if (v === 'cfg') {
            document.cookie = 'beautek_cfg_pills=1;path=/;max-age=2592000;SameSite=Lax';
        } else if (v === 'off') {
            document.cookie = 'beautek_cfg_pills=;path=/;max-age=0;SameSite=Lax';
        }
    } catch (e) {}
})();
</script>
{/if}
