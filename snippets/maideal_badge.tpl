{* MaiDeal-Badge bei aktivem JTL-Sonderpreis ($Artikel->Preise->Sonderpreis_aktiv) *}
{strip}
{assign var=maidealShow value=false}
{if $Artikel->kArtikel|default:false
    && isset($Artikel->Preise->Sonderpreis_aktiv)
    && $Artikel->Preise->Sonderpreis_aktiv}
    {assign var=maidealShow value=true}
{/if}
{/strip}
{if $maidealShow}
<div class="maideal-badge-layer">
    <span class="maideal-badge">
        <span class="maideal-badge__mai">Mai</span><span class="maideal-badge__deal">Deal</span>
    </span>
</div>
{/if}
