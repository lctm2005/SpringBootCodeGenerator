<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>SQL转Java JPA、MYBATIS实现类代码生成平台</title>
    <meta name="keywords" content="sql转实体类,sql转DAO,SQL转service,SQL转JPA实现,SQL转MYBATIS实现">
<#import "common/common-import.ftl" as netCommon>
<@netCommon.commonStyle />

<@netCommon.commonScript />
<#--<script src="${request.contextPath}/static/js/index-new.js"></script>-->
    <script>
        $(function () {

            /**
             * 初始化 table sql 3
             */
            var ddlSqlArea = CodeMirror.fromTextArea(document.getElementById("ddlSqlArea"), {
                lineNumbers: true,
                matchBrackets: true,
                mode: "text/x-sql",
                lineWrapping: false,
                readOnly: false,
                foldGutter: true,
                gutters: ["CodeMirror-linenumbers", "CodeMirror-foldgutter"]
            });
            ddlSqlArea.setSize('auto', 'auto');
            // controller_ide
            var genCodeArea = CodeMirror.fromTextArea(document.getElementById("genCodeArea"), {
                lineNumbers: true,
                matchBrackets: true,
                mode: "text/x-java",
                lineWrapping: true,
                readOnly: true,
                foldGutter: true,
                gutters: ["CodeMirror-linenumbers", "CodeMirror-foldgutter"]
            });
            genCodeArea.setSize('auto', 'auto');

            var codeData;

            /**
             * 生成代码
             */
            $('#btnGenCode').click(function () {

                var tableSql = ddlSqlArea.getValue();
                $.ajax({
                    type: 'POST',
                    url: base_url + "/genCode",
                    data: {
                        "tableSql": tableSql,
                        "packageName": $("#packageName").val(),
                        "authorName": $("#authorName").val()
                    },
                    dataType: "json",
                    success: function (data) {
                        if (data.code == 200) {
                            layer.open({
                                icon: '1',
                                content: "代码生成成功",
                                end: function () {
                                    codeData = data.data;
                                    genCodeArea.setValue(codeData.entity);
                                    genCodeArea.setSize('auto', 'auto');
                                }
                            });
                        } else {
                            layer.open({
                                icon: '2',
                                content: (data.msg || '代码生成失败')
                            });
                        }
                    }
                });
            });
            /**
             * 按钮事件组
             */
            $('.generator').bind('click', function () {
                if (!$.isEmptyObject(codeData)) {
                    var id = this.id;
                    genCodeArea.setValue(codeData[id]);
                    genCodeArea.setSize('auto', 'auto');
                }
            });

        });
    </script>
</head>
<body style="background-color: #e9ecef">

<!-- Main jumbotron for a primary marketing message or call to action -->
<div class="jumbotron">
    <div class="container">
        <h2>Spring Boot Code Generator!</h2>
        <div class="input-group mb-3">
            <div class="input-group-prepend">
                <span class="input-group-text">作者名称</span>
            </div>
            <input type="text" class="form-control" id="authorName" name="authorName" placeholder="licong">
            <div class="input-group-prepend">
                <span class="input-group-text">包名路径</span>
            </div>
            <input type="text" class="form-control" id="packageName" name="packageName" placeholder="com.nd.elearning">
        </div>
        <textarea id="ddlSqlArea" placeholder="请输入表结构信息..." class="form-control btn-lg" style="height: 250px;">
CREATE TABLE IF NOT EXISTS `example` (
  `_id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `id` VARCHAR(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'UUID',
  `name` VARCHAR(50) CHARACTER SET utf8 NOT NULL COMMENT '名称',
  `user_id` BIGINT(20) NOT NULL COMMENT '用户ID',
  `description` VARCHAR(500) NOT NULL DEFAULT '' COMMENT '描述',
  `status` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '状态',
  `project_id` BIGINT(20) NOT NULL COMMENT '项目ID',
  `create_user` BIGINT(20) NOT NULL COMMENT '创建人',
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_user` BIGINT(20) NOT NULL COMMENT '更新人',
  `update_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
   PRIMARY KEY (`_id`),
   UNIQUE KEY `uni_idx_id` (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='范例';
        </textarea><br>
        <p>
            <button class="btn btn-primary btn-lg disabled" id="btnGenCode" role="button">开始生成 »</button>
        </p>
        <hr>
        <!-- Example row of columns -->
        <div class="row" style="margin-top: 10px;">
            <div class="btn-toolbar col-md-5" role="toolbar" aria-label="Toolbar with button groups">
                <div class="input-group">
                    <div class="input-group-prepend">
                        <div class="btn btn-secondary disabled" id="btnGroupAddon">JPA</div>
                    </div>
                </div>
                <div class="btn-group" role="group" aria-label="First group">
                    <button type="button" class="btn btn-default generator" id="entity">jpa-entity</button>
                    <button type="button" class="btn btn-default generator" id="repository">repository</button>
                </div>
            </div>
        </div>
        <hr>
        <textarea id="genCodeArea" class="form-control btn-lg"></textarea>
    </div>
</div>

<div class="container">

    <hr>
    <footer>
        <footer class="bd-footer text-muted" role="contentinfo">
            <div class="container">
                <strong>Copyright &copy; ${.now?string('yyyy')}-2022 &nbsp;
                    <p>基于开源项目定制,开源项目地址：<a href="https://github.com/moshowgame/SpringBootCodeGenerator">SpringBootCodeGenerator</a>
            </div>
        </footer>
    </footer>
</div> <!-- /container -->


</body>
</html>
