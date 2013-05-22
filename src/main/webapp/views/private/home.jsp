<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h1 class="page-header">All Movies</h1>

<c:if test="${param.passwordChanged == 3}">
    <div class="alert alert-success">
        <button type="button" class="close" data-dismiss="alert">&times;</button>
        <p><strong>Congratulations!</strong> Your password has been changed. You'll have to use it the next time you log in.</p>
    </div>
</c:if>

<p class="page-paragraph">Here is listed all the current availible movies in alphabetical order. If you want to filter the list of movies by genre, please select the genre at the top of the page. You can also do a search on a movie title or a part of it, by using the search box.</p>

<c:forEach items="${movies}" var="listOfMovies">

    <c:choose>
        <c:when test="${listOfMovies.get(0).title.substring(0, 1).matches('[0-9]')}">
            <h3 class="muted">0-9</h3>
            <hr />
        </c:when>
        <c:otherwise>
            <h3 class="muted"><c:out value="${listOfMovies.get(0).title.substring(0, 1)}" /></h3>
        <hr />
        </c:otherwise>
    </c:choose>
    
    <ul class="thumbnails">
    <c:forEach items="${listOfMovies}" var="movie">
        
        <c:choose>
            <c:when test="${empty movie.season}">
                <li>
                    <div rel="popover" data-content="<p><c:out value="${movie.description}" /><br /><strong>Genre:</strong> <span class='text-info'><c:out value="${movie.genre.title}" /></span></p><a href='<c:out value="${pageContext.servletContext.contextPath}" />/movie/show/<c:out value="${movie.id}" />' class='btn btn-success btn-large btn-block'><i class='icon-play icon-white'></i> Play Movie</a>" data-original-title="<c:out value="${movie.title}" />" class="thumbnail">
                        <img src="http://placehold.it/160x200" alt="" />
                        <p class="text-center"><c:out value="${movie.title}" /></p>
                    </div>
                </li>
            </c:when>
            <c:otherwise>
                <li>
                    <div rel="popover" data-content="<p><c:out value="${movie.season.description}" /><br /><strong>Genre:</strong> <span class='text-info'><c:out value="${movie.genre.title}" /></span></p><a href='<c:out value="${pageContext.servletContext.contextPath}" />/season/showepisodes/<c:out value="${movie.season.id}" />' class='btn btn-success btn-large btn-block'><i class='icon-share-alt icon-white'></i> Show Episodes</a>" data-original-title="<c:out value="${movie.title}" />" class="thumbnail">
                        <img src="http://placehold.it/160x200" alt="" />
                        <p class="text-center"><c:out value="${movie.season.title}" /></p>
                    </div>
                </li>
            </c:otherwise>
        </c:choose>
    </c:forEach>
    </ul>
    
</c:forEach>

<script type="text/javascript">
    $(document).ready(function(){
        $('.thumbnail').popover({
            placement: 'top',
            delay: 300,
            html: true
        }, 'show'); 
    });
</script>

<c:if test="${changePasswordDialog eq true}">
    <form method="post" action="<c:out value="${pageContext.servletContext.contextPath}" />/user/changePasswordFirstTime.do">
        <div id="change-password-modal" class="modal hide fade">
            <div class="modal-header">
                <h3>Change Your Password</h3>
            </div>
            <div class="modal-body">
                <p>It seems that your password is the 'default' password. You have to change your password to continue.</p>

                <input type="hidden" name="oldPassword" value="default" />
                    
                <c:choose>
                    <c:when test="${param.passwordChanged == 1}">
                        <div class="alert alert-error">
                            <button type="button" class="close" data-dismiss="alert">&times;</button>
                            <p><strong>Error!</strong> New Password need to be at least 6 characters long</p>
                        </div>
                        
                        <div class="control-group error">
                            <label class="control-label" for="inputNewPassword">New Password</label>
                            <div class="controls">
                                <input class="span4" type="password" name="newPassword" id="inputNewPassword" placeholder="New Password">
                            </div>
                        </div>
        
                        <div class="control-group error">
                            <label class="control-label" for="inputRepeatNewPassword">Repeat New Password</label>
                            <div class="controls">
                                <input class="span4" type="password" name="repeatNewPassword" id="inputRepeatNewPassword" placeholder="Repeat New Password">
                            </div>
                        </div>
                    </c:when>
                    <c:when test="${param.passwordChanged == 2}">
                        <div class="alert alert-error">
                            <button type="button" class="close" data-dismiss="alert">&times;</button>
                            <p><strong>Error!</strong> The two new passwords doesn't match each other</p>
                        </div>
                        
                        <div class="control-group error">
                            <label class="control-label" for="inputNewPassword">New Password</label>
                            <div class="controls">
                                <input class="span4" type="password" name="newPassword" id="inputNewPassword" placeholder="New Password">
                            </div>
                        </div>
        
                        <div class="control-group error">
                            <label class="control-label" for="inputRepeatNewPassword">Repeat New Password</label>
                            <div class="controls">
                                <input class="span4" type="password" name="repeatNewPassword" id="inputRepeatNewPassword" placeholder="Repeat New Password">
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="control-group">
                            <label class="control-label" for="inputNewPassword">New Password</label>
                            <div class="controls">
                                <input class="span4" type="password" name="newPassword" id="inputNewPassword" placeholder="New Password">
                            </div>
                        </div>
        
                        <div class="control-group">
                            <label class="control-label" for="inputRepeatNewPassword">Repeat New Password</label>
                            <div class="controls">
                                <input class="span4" type="password" name="repeatNewPassword" id="inputRepeatNewPassword" placeholder="Repeat New Password">
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="modal-footer">
                <button type="submit" class="btn btn-info">Change Password</button>
            </div>
        </div>
    </form>

    <script type="text/javascript">
        $(document).ready(function(){
            $('#change-password-modal').modal({
                backdrop: 'static',
                show: true,
                keyboard: false
            }); 
        });
    </script>
</c:if>
