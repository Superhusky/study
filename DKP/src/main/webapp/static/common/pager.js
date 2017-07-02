
/**
 * 显示分页导航条
 * @param containerId 导航条所在容器标签ID
 * @param currentPage 当前页码
 * @param pageSize 每页多少条数据
 * @param totalCount 总共多少条数据
 * @param prevFuncName 前一页处理函数名(无参数)
 * @param nextFuncName 后一页处理函数(无参数)
 * @param pageFuncName 指定页处理函数(一个参数,值为所查询的页码)
 */
function showPager(containerId, currentPage, pageSize, totalCount, prevFuncName, nextFuncName, pageFuncName) {
	var pageCount = Math.ceil(totalCount / pageSize);
	var pagingHtml;
	if (currentPage == 1) {
		pagingHtml = '<a class="icon item disabled"><i class="angle left icon"></i></a>';
	} else {
		pagingHtml = '<a class="icon item" onclick="' + prevFuncName + '()"><i class="angle left icon"></i></a>';
	}
	if (pageCount <= 9) {
		for (var i = 1; i <= pageCount; i++) {
			if (currentPage == i) {
				pagingHtml += '<a class="item active">' + i + '</a>';
			} else {
				pagingHtml += '<a class="item" onclick="' + pageFuncName + '(' + i + ')">' + i + '</a>';
			}
		}
	} else {
		if (currentPage <= 4) {
			for (var i = 1; i <= 5; i++) {
				if (currentPage == i) {
					pagingHtml += '<a class="item active">' + i + '</a>';
				} else {
					pagingHtml += '<a class="item" onclick="' + pageFuncName + '(' + i + ')">' + i + '</a>';
				}
			}
			pagingHtml += '<a class="icon item disabled">...</a>';
			pagingHtml += '<a class="icon item" onclick="' + pageFuncName + '(' + (pageCount - 1) + ')">' + (pageCount - 1) + '</a>';
			pagingHtml += '<a class="icon item" onclick="' + pageFuncName + '(' + (pageCount) + ')">' + (pageCount) + '</a>';
		} else if (currentPage > (pageCount - 4)) {
			pagingHtml += '<a class="icon item" onclick="' + pageFuncName + '(1)">1</a>';
			pagingHtml += '<a class="icon item" onclick="' + pageFuncName + '(2)">2</a>';
			pagingHtml += '<a class="icon item disabled">...</a>';
			for (var i = (pageCount - 4); i <= pageCount; i++) {
				if (currentPage == i) {
					pagingHtml += '<a class="item active">' + i + '</a>';
				} else {
					pagingHtml += '<a class="item" onclick="' + pageFuncName + '(' + i + ')">' + i + '</a>';
				}
			}
		} else {
			pagingHtml += '<a class="icon item" onclick="' + pageFuncName + '(1)">1</a>';
			pagingHtml += '<a class="icon item" onclick="' + pageFuncName + '(2)">2</a>';
			if (currentPage - 2 == 3) {
				pagingHtml += '<a class="icon item" onclick="' + pageFuncName + '(3)">3</a>';
			} else {
				pagingHtml += '<a class="icon item disabled">...</a>';
			}
			for (var i = (currentPage - 1); i <= (currentPage + 1); i++) {
				if (currentPage == i) {
					pagingHtml += '<a class="item active">' + i + '</a>';
				} else {
					pagingHtml += '<a class="item" onclick="' + pageFuncName + '(' + i + ')">' + i + '</a>';
				}
			}
			if (currentPage + 2 == pageCount - 2) {
				pagingHtml += '<a class="icon item" onclick="' + pageFuncName + '(' + (pageCount - 2) + ')">' + (pageCount - 2) + '</a>';
			} else {
				pagingHtml += '<a class="icon item disabled">...</a>';
			}
			pagingHtml += '<a class="icon item" onclick="' + pageFuncName + '(' + (pageCount - 1) + ')">' + (pageCount - 1) + '</a>';
			pagingHtml += '<a class="icon item" onclick="' + pageFuncName + '(' + (pageCount) + ')">' + (pageCount) + '</a>';
		}
	}
	if (currentPage == pageCount) {
		pagingHtml += '<a class="icon item disabled"><i class="angle right icon"></i></a>';
	} else {
		pagingHtml += '<a class="icon item" onclick="' + nextFuncName + '()"><i class="angle right icon"></i></a>';
	}
	$('#' + containerId + ' .item').remove();
	$('#' + containerId).html(pagingHtml);
}