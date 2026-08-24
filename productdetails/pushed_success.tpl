{block name='productdetails-pushed-success'}
    {* Großes Banner auf der Produktseite unterdrücken – Meldung erscheint in der Cart-Sidebar. *}
    {if isset($bWarenkorbHinzugefuegt) && $bWarenkorbHinzugefuegt}
        <script>
            window.__beautekCartJustAdded = true;
            window.__beautekCartSuccessMsg = "{if isset($cartNote) && $cartNote !== ''}{$cartNote|escape:'javascript'}{else}Dieser Artikel befindet sich nun in Ihrem Warenkorb.{/if}";
        </script>
    {/if}
{/block}
