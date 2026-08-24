{extends file="{$parent_template_path}/productdetails/question_on_item.tpl"}

{*
  Beautek: Im Popup „Frage zum Artikel“ zusätzlich WhatsApp-CTA anbieten.
  Öffnet WhatsApp mit vorbefüllter Nachricht inkl. Artikelname/-URL.
*}
{block name='productdetails-question-on-item-form-submit'}
    {input type="hidden" name="a" value=$Artikel->kArtikel}
    {input type="hidden" name="show" value="1"}
    {input type="hidden" name="fragezumprodukt" value="1"}

    {if isset($position) && $position === 'popup'}
        {$beautekWaText = "Hallo, ich habe eine Frage zum Artikel: {$Artikel->cName|default:''}"}
        {if !empty($Artikel->cURLFull)}
            {$beautekWaText = "{$beautekWaText} ({$Artikel->cURLFull})"}
        {/if}
        {$beautekWaHref = "https://wa.me/492713137430?text={$beautekWaText|escape:'url'}"}

        {row class="question-on-item-actions align-items-center"}
            {col cols=12 md=6 class="question-on-item-actions__whatsapp mb-2 mb-md-0"}
                <a href="{$beautekWaHref}"
                   class="btn btn-outline-primary btn-block question-on-item-whatsapp"
                   target="_blank"
                   rel="noopener noreferrer">
                    <i class="fab fa-whatsapp" aria-hidden="true"></i>
                    Per WhatsApp fragen
                </a>
            {/col}
            {col cols=12 md=6 class="question-on-item-actions__submit ml-md-auto-util"}
                {button type="submit" value="1" variant="primary" block=true}
                    {lang key='sendQuestion' section='productDetails'}
                {/button}
            {/col}
        {/row}
    {else}
        {row}
            {col md='auto' class="ml-auto-util"}
                {button type="submit" value="1" variant="primary" block=true}
                    {lang key='sendQuestion' section='productDetails'}
                {/button}
            {/col}
        {/row}
    {/if}
{/block}
