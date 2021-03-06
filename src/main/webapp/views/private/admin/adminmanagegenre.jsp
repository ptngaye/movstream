<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<c:if test="${not empty param.edited}">
    <div class="alert alert-success">
        <button type="button" class="close" data-dismiss="alert">&times;</button>
        <p><strong><spring:message code="overall.congratulations.label" />!</strong> <spring:message code="page.adminmanagegenre.dialog.success.edited.message" />.</p>
    </div>
</c:if>

<c:if test="${not empty param.deleted}">
    <div class="alert alert-success">
        <button type="button" class="close" data-dismiss="alert">&times;</button>
        <p><strong><spring:message code="overall.congratulations.label" />!</strong> <spring:message code="page.adminmanagegenre.dialog.success.deleted.message" />.</p>
    </div>
</c:if>

<p class="muted"><spring:message code="page.adminmanagegenre.pagedescription.label" />.</p>

<br />

<c:if test="${!genres.isEmpty()}">

<table class="table table-striped table-condensed table-bordered table-sorter">
    <thead>
        <tr>
            <th>#</th>
            <th><spring:message code="page.adminmanagegenre.table.genre.label" /></th>
        </tr>
    </thead>
    <tbody>
        <c:forEach items="${genres}" var="genre">
            <tr>
                <td style="width: 40px;"><c:out value="${genre.id}" /></td>
                <td><c:out value="${genre.title}" /></td>
                <td style="width: 80px;"><a href="<c:out value="${pageContext.servletContext.contextPath}" />/admin/genre/edit?editGenreId=<c:out value="${genre.id}" />" class="btn btn-warning btn-mini"><i class="icon-edit icon-white"></i> <spring:message code="page.adminmanagegenre.button.edit.label" /></a></td>
                <td style="width: 80px;">
                    <sec:authorize access="hasRole('ROLE_TEST')">
                    <a href="#modal-delete-container" data-id="<c:out value="${genre.id}" />" class="btn btn-danger btn-mini trigger-delete-genre disabled"><i class="icon-remove-circle icon-white"></i> <spring:message code="page.adminmanagegenre.button.delete.label" /></a>
                    </sec:authorize>
                    <sec:authorize access="hasRole('ROLE_SUPERADMIN') or hasRole('ROLE_ADMIN')">
                    <a href="#modal-delete-container" data-id="<c:out value="${genre.id}" />" class="btn btn-danger btn-mini trigger-delete-genre"><i class="icon-remove-circle icon-white"></i> <spring:message code="page.adminmanagegenre.button.delete.label" /></a>
                    </sec:authorize>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>

</c:if>
        
<div id="modal-delete-container" class="modal hide fade">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h3><spring:message code="page.adminmanagegenre.dialog.delete.headline.label" /></h3>
    </div>
    <div class="modal-body">
        <p><spring:message code="page.adminmanagegenre.dialog.delete.infomessage.label" />!</p>
        <p><spring:message code="overall.info.areyousure.label" /></p>
    </div>
    <div class="modal-footer">
        <a href="<c:out value="${pageContext.servletContext.contextPath}" />/admin/genre/delete?deleteGenreId=" class="btn btn-danger delete-genre-btn"><spring:message code="overall.yes.label" /></a>
        <a href="" class="btn" data-dismiss="modal" aria-hidden="true"><spring:message code="overall.no.label" /></a>
    </div>
</div>

<script src="<c:out value="${pageContext.servletContext.contextPath}" />/resources/js/sorttable.js"></script>

<script type="text/javascript">
    $('#modal-delete-container').bind('show', function() {
        var id = $(this).data('id'),
        removeBtn = $(this).find('.delete-genre-btn'),
        href = removeBtn.attr('href');
        
        removeBtn.attr('href', href.replace(/deleteGenreId=\d*/, 'deleteGenreId=' + id));
    })
    .modal({ backdrop: true, show: false });
    
    $('.trigger-delete-genre').click(function(e) {
        e.preventDefault();
        
        if (!$(this).hasClass('disabled'))
        {
            var id = $(this).data('id');
            $('#modal-delete-container').data('id', id).modal('show');
        }
    });
</script>
