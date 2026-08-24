{block name='productdetails-config-container'}
{block name='productdetails-config-container-main'}
		{col cols=12 id="cfg-headline"}
			{row class="text-center"}
				{col cols=12}
					<div class="cfg-headline h2">{lang section="custom" key="cfg_headline"}</div>
				{/col}
			{/row}
		{/col}
        {col cols=12 id="cfg-container"}
			{row}
				{col cols=12 lg=7 class="config-content"}
					<div class="tab-content" id="cfg-container-tab-panes">
						<div class="tab-pane fade show active" id="cfg-tab-pane-options" role="tabpanel" aria-labelledby="cfg-tab-options">
							{block name='productdetails-config-container-options'}
								{if $Einstellungen.template.productdetails.config_layout === 'list'}
		                            {include file='productdetails/config_options_list.tpl'}
		                       {else}
		                            {include file='productdetails/config_options_gallery.tpl'}
		                       {/if}
							{/block}
						</div>
					</div>
				{/col}

				{col cols=12 lg=5 class="config-sidebar"}
					<div class="config-sidebar-wrapper">
						<div class="custom-config-title h3">{lang key='yourConfiguration'}</div>
						<div class="tab-pane" id="cfg-tab-pane-summary" role="tabpanel" aria-labelledby="cfg-tab-summary">
							{block name='productdetails-config-container-include-config-sidebar'}
								{include file='productdetails/config_sidebar.tpl'}
							{/block}
						</div>

						{*nav id="cfg-modal-tabs" pills=true fill=true role="tablist"}
							{navitem id="cfg-tab-options" active=true
								href="#cfg-tab-pane-options" role="tab" router-data=["toggle"=>"pill"]
								router-aria=["controls"=>"cfg-tab-pane-options", "selected"=>"true"]
							}
								<i class="fas fa-cogs"></i> <span class="nav-link-text">{lang key='configComponents' section='productDetails'}</span>
							{/navitem}
							{navitem id="cfg-tab-summary"
								href="#cfg-tab-pane-summary" role="tab" router-data=["toggle"=>"pill"]
								router-aria=["controls"=>"cfg-tab-pane-summary", "selected"=>"false"]
							}
								<i class="fas fa-cart-plus"></i> <span class="nav-link-text">{lang key='yourConfiguration'}</span>
							{/navitem}
							{navitem href="#" disabled=true class="cfg-tab-total"}
								<strong id="cfg-price" class="price"></strong>&nbsp;<span class="footnote-reference">*</span>
							{/navitem}
						{/nav*}
						{*<div class="cfg-footnote small">
							<span class="footnote-reference">*</span>{include file='snippets/shipping_tax_info.tpl' taxdata=$Artikel->taxData}
						</div>*}


					</div>
				{/col}
			{/row}




        {/col}
    {/block}
    {*block name='productdetails-config-container-script'}
        {if isset($kEditKonfig) && !isset($bWarenkorbHinzugefuegt)}
            {inline_script}<script>
                $('#cfg-container').modal('show');
            </script>{/inline_script}
        {/if}
    {/block*}

	{literal}
		<script>
			$('.config-sidebar .cfg-price .price').text($('.product-offer .price.h1').text());
			$('.product-offer .price.h1').on('DOMSubtreeModified',function(){
				$('.config-sidebar .cfg-price .price').text($(this).text());
			});
		</script>
		<script>
			$('#cfg-accordion .hr-sect').on('click', function () {
				$('.collapse', $(this).closest('.cfg-group')).toggleClass('show');
				$($(this).closest('.cfg-group')).toggleClass('active');
			});
			jQuery(document).ready(function($) {
				$('.product-offer .rate-info-row').insertAfter('#cstmPayPal');
			});
		</script>
	{/literal}
{/block}
