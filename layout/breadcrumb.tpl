 {block name='layout-breadcrumb-first-item'}
	{breadcrumbitem class="first"
		router-tag-itemprop="url"
		href=$oItem->getURLFull()
		title={sanitizeTitle title=$oItem->getName()}
		itemprop="itemListElement"
		itemscope=true
		itemtype="https://schema.org/ListItem"
	}
		<span itemprop="name"><b>Beautek.de</b></span>
		<meta itemprop="item" content="{$oItem->getURLFull()}" />
		<meta itemprop="position" content="{$oItem@iteration}" />
	{/breadcrumbitem}
{/block}