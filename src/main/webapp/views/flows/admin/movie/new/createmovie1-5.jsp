<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<h3>New Movie</h3>

<div class="span4">
    
    <form:form modelAttribute="genreObject" action="${flowExecutionUrl}">
        <div class="control-group">
            <label class="control-label" for="inputTitle"><strong>Genre Title</strong></label>
            <div class="controls">
                <form:input class="span4" path="title" id="inputTitle" placeholder="Genre Title" />
            </div>
        </div>
            
        <div class="control-group">
            <div class="controls pull-right">
                <button type="submit" class="btn btn-danger btn-small" id="back" name="_eventId_back"><i class="icon-remove-circle icon-white"></i> <strong>Don't Create</strong></button>
                <button type="submit" class="btn btn-success btn-small" id="create" name="_eventId_create"><i class="icon-ok-circle icon-white"></i> <strong>Create</strong></button>
            </div>
        </div>
    </form:form>
    
</div>

<div class="progress-flow">
    <hr />
        
    <p class="muted text-center">Step 1 of 4</p>
        
    <div class="progress progress-striped active">
        <div class="bar" data-percentage="25"></div>
    </div>
    
    <br />
</div>

<script type="text/javascript">
$(document).ready(function() {
    $('.progress .bar').progressbar({
        transition_delay: 400,
        display_text: 1
    });
});
</script>