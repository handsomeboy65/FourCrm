<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<script>
    jQuery(function($){
        if ( $("select[owner]").size() != 0 ) {
            // 加载所有者
            $.ajax({
                url: "/user/getAll.json",
                success:function(data) {
                    // data: ["10000|张三", "10001|李四",...]
                    $(data).each(function () {
                        $("select[owner]").append("<option value='"+this.name+"'>" + this.name + "</option>")
                    });
                }
            });
        }
    });
</script>
