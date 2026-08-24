{block name='boxes-box-categories-include-categories-recursive'}
	{include file='snippets/categories_recursive.tpl'
		i=0
		categoryId=5
		categoryBoxNumber=$oBox->getCustomID()
		limit=5
		categories=$oBox->getItems()
		id=$oBox->getID()} 
{/block}