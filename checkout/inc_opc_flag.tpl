{*
  Beautek One-Page-Checkout (Testkreis)
  Aktivieren:   ?opc=beautek-opc-2026
  Deaktivieren: ?opc=off
*}

{if !isset($beautekOpcEmitCookie)}
    {$beautekOpcEmitCookie = false}
{/if}
{if !isset($beautekOpcShowBanner)}
    {$beautekOpcShowBanner = false}
{/if}

{if isset($smarty.get.opc)}
    {if $smarty.get.opc === 'beautek-opc-2026'}
        {assign var='beautekOpc' value=true scope='global'}
    {else}
        {assign var='beautekOpc' value=false scope='global'}
    {/if}
{elseif isset($smarty.cookies.beautek_opc) && $smarty.cookies.beautek_opc == '1'}
    {assign var='beautekOpc' value=true scope='global'}
{elseif !isset($beautekOpc)}
    {assign var='beautekOpc' value=false scope='global'}
{/if}

{if $beautekOpcEmitCookie && isset($smarty.get.opc)}
<script>
(function () {
    try {
        var on = {if $smarty.get.opc === 'beautek-opc-2026'}true{else}false{/if};
        if (on) {
            document.cookie = 'beautek_opc=1;path=/;max-age=2592000;SameSite=Lax';
        } else {
            document.cookie = 'beautek_opc=;path=/;max-age=0;SameSite=Lax';
        }
    } catch (e) {}
})();
</script>
{/if}

{if $beautekOpcShowBanner && $beautekOpc}
    <div class="beautek-opc-flag">
        One-Page-Checkout-Vorschau aktiviert (nur Testkreis)
        <a class="beautek-opc-flag__off" href="?opc=off">Vorschau aus</a>
    </div>
{/if}
