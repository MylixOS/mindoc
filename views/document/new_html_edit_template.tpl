<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>编辑文档 - Powered by MinDoc</title>
    <script type="text/javascript">
        window.editor = null;
        window.imageUploadURL = "{{urlfor "DocumentController.Upload" "identify" .Model.Identify}}";
        window.fileUploadURL = "{{urlfor "DocumentController.Upload" "identify" .Model.Identify}}";
        window.documentCategory = {{.Result}};
        window.book = {{.ModelResult}};
        window.selectNode = null;
        window.deleteURL = "{{urlfor "DocumentController.Delete" ":key" .Model.Identify}}";
        window.editURL = "{{urlfor "DocumentController.Content" ":key" .Model.Identify ":id" ""}}";
        window.releaseURL = "{{urlfor "BookController.Release" ":key" .Model.Identify}}";
        window.sortURL = "{{urlfor "BookController.SaveSort" ":key" .Model.Identify}}";
        window.historyURL = "{{urlfor "DocumentController.History"}}";
        window.removeAttachURL = "{{urlfor "DocumentController.RemoveAttachment"}}";
    </script>
    <!-- Bootstrap -->
    <link href="{{cdncss "/static/bootstrap/css/bootstrap.min.css"}}" rel="stylesheet">
    <link href="{{cdncss "/static/font-awesome/css/font-awesome.min.css"}}" rel="stylesheet">
    <link href="{{cdncss "/static/jstree/3.3.4/themes/default/style.min.css"}}" rel="stylesheet">
    <link href="{{cdncss "/static/css/jstree.css"}}" rel="stylesheet">
    <link href="{{cdncss "/static/highlight/styles/zenburn.css"}}" rel="stylesheet">
    <link href="{{cdncss "/static/webuploader/webuploader.css"}}" rel="stylesheet">
    <link href="{{cdncss "/static/css/markdown.css"}}" rel="stylesheet">
    <link href="{{cdncss "/static/prettify/themes/atelier-estuary-dark.min.css"}}" rel="stylesheet">
    <link href="{{cdncss "/static/css/markdown.preview.css"}}" rel="stylesheet">
    {{/*<link href="/static/bootstrap/plugins/bootstrap-wysiwyg/external/google-code-prettify/prettify.css" rel="stylesheet">*/}}
    <link href="/static/katex/katex.min.css" rel="stylesheet">
    <link href="/static/quill/quill.core.css" rel="stylesheet">
    <link href="/static/quill/quill.snow.css" rel="stylesheet">
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="/static/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="/static/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <style type="text/css">
        #docEditor {overflow:auto;border: 1px solid #ddd; height: 100%;outline:none;padding: 5px;}
        .btn-info{background-color: #ffffff !important;}
        .btn-info>i{background-color: #cacbcd !important; color: #393939 !important; box-shadow: inset 0 0 0 1px transparent,inset 0 0 0 0 rgba(34,36,38,.15);}
        .editor-wrapper>pre{padding: 0;}
        .editor-wrapper .editor-code{
            font-size: 13px;
            line-height: 1.8em;
            color: #dcdcdc;
            border-radius: 3px;
            display: block;
            overflow-x: auto;
            padding: 0.5em;
            background: #3f3f3f;
        }
        .editor-wrapper-selected .editor-code{border: 1px solid #1e88e5;}

        .ql-toolbar.ql-snow{
            border: none !important;
        }
        .editor-group{
            float: left;
            height: 32px;
            margin-right: 10px;
        }

        .editor-group .editor-item{
            float: left;
            display: inline-block;
            width: 34px !important;
            height: 30px !important;
            padding: 5px !important;
            line-height: 30px;
            text-align: center;
            color: #4b4b4b;
            border-top: 1px solid #ccc !important;
            border-left: 1px solid #ccc !important;
            border-bottom: 1px solid #ccc !important;
            background: #fff;
            border-radius: 0;
            font-size: 12px
        }
        .editor-group .editor-item-last{
            border-right: 1px solid #ccc !important;
            border-radius: 0 4px 4px 0;
        }
        .editor-group .editor-item-first{
            border-right: 0;
            border-radius: 4px  0 0 4px;
        }
        .editor-group .disabled:hover{
            background: #ffffff !important;
        }
        .editor-group .editor-item-change:hover{
             background-color: #58CB48 !important;
        }
        .editor-group  .editor-item:hover {
            background-color: #e4e4e4;
            color: #4b4b4b !important;
        }

        .editor-group a{
            float: left;
        }

        .editor-group .change i{
            color: #ffffff;
            background-color: #44B036 !important;
            border: 1px #44B036 solid !important;
        }
        .editor-group .change i:hover{
            background-color: #58CB48 !important;
        }
        .editor-group .disabled i:hover{
            background: #ffffff !important;
        }
        .editor-group a.disabled{
            border-color: #c9c9c9;
            opacity: .6;
            cursor: default
        }
        .editor-group a>i{
            display: inline-block;
            width: 34px !important;
            height: 30px !important;
            line-height: 30px;
            text-align: center;
            color: #4b4b4b;
            border: 1px solid #ccc;
            background: #fff;
            border-radius: 4px;
            font-size: 15px
        }
        .editor-group a>i.item{
            border-radius: 0;
            border-right: 0;
        }
        .editor-group a>i.last{
            border-bottom-left-radius:0;
            border-top-left-radius:0;
        }
        .editor-group a>i.first{
            border-right: 0;
            border-bottom-right-radius:0;
            border-top-right-radius:0;
        }
        .editor-group  a i:hover {
            background-color: #e4e4e4
        }

        .editor-group  a i:after {
            display: block;
            overflow: hidden;
            line-height: 30px;
            text-align: center;
            font-family: icomoon,Helvetica,Arial,sans-serif;
            font-style: normal;
        }
    </style>
</head>
<body>

<div class="m-manual manual-editor">
    <div class="manual-head btn-toolbar" id="editormd-tools" data-role="editor-toolbar" data-target="#editor">
        <div class="editor-group">
            <a href="{{urlfor "BookController.Index"}}" data-toggle="tooltip" data-title="返回"><i class="fa fa-chevron-left" aria-hidden="true"></i></a>
        </div>
        <div class="editor-group">
            <a href="javascript:;" id="markdown-save" data-toggle="tooltip" data-title="保存" class="disabled save"><i class="fa fa-save" aria-hidden="true" name="save"></i></a>
        </div>
        <div class="editor-group">
            <a href="javascript:;" data-toggle="tooltip" data-title="撤销 (Ctrl-Z)" class="ql-undo"><i class="fa fa-undo first" name="undo" unselectable="on"></i></a>
            <a href="javascript:;" data-toggle="tooltip" data-title="重做 (Ctrl-Y)" class="ql-redo"><i class="fa fa-repeat last" name="redo" unselectable="on"></i></a>
        </div>
        <div class="editor-group">
            <button data-toggle="tooltip" data-title="粗体" class="ql-bold editor-item editor-item-first"></button>
            <button data-toggle="tooltip" data-title="斜体" class="ql-italic editor-item"></button>
            <button data-toggle="tooltip" data-title="删除线" class="ql-underline editor-item editor-item-last"></button>
        </div>
        <div class="editor-group">
            <button data-toggle="tooltip" data-title="标题一" class="ql-header editor-item editor-item-first" value="1"></button>
            <button data-toggle="tooltip" data-title="标题二" class="ql-header editor-item" value="2"></button>
            <button data-toggle="tooltip" data-title="标题三" class="ql-header editor-item" value="3"></button>
            <button data-toggle="tooltip" data-title="标题四" class="ql-header editor-item" value="4"></button>
            <button data-toggle="tooltip" data-title="标题五" class="ql-header editor-item" value="5"></button>
            <button data-toggle="tooltip" data-title="标题六" class="ql-header editor-item editor-item-last" value="6"></button>
        </div>
        <div class="editor-group">
            <button data-toggle="tooltip" data-title="无序列表" class="ql-list editor-item editor-item-first" value="ordered"></button>
            <button data-toggle="tooltip" data-title="有序列表" class="ql-list editor-item" value="bullet"></button>
            <button data-toggle="tooltip" data-title="右缩进" class="ql-indent editor-item" value="-1"></button>
            <button data-toggle="tooltip" data-title="左缩进" class="ql-indent editor-item editor-item-last" value="+1"></button>
        </div>
        <div class="editor-group ql-formats">
            <button data-toggle="tooltip" data-title="链接" class="ql-link editor-item editor-item-first"></button>
            <a href="javascript:;" data-toggle="tooltip" data-title="引用链接"><i class="fa fa-anchor item" name="reference-link" unselectable="on"></i></a>
            <button data-toggle="tooltip" data-title="添加图片" class="ql-image editor-item"></button>
            <button data-toggle="tooltip" data-title="代码块" class="ql-code-block editor-item"></button>
            <button data-toggle="tooltip" data-title="添加表格" class="ql-table editor-item"></button>
            <button data-toggle="tooltip" data-title="引用" class="ql-blockquote editor-item"><i class="fa fa-quote-right item" name="quote" unselectable="on"></i></button>
            <button data-toggle="tooltip" data-title="公式" class="ql-formula editor-item"><i class="fa fa-tasks item" name="tasks" aria-hidden="true"></i></button>
            <select data-toggle="" data-title="" class="ql-color ql-picker ql-color-picker editor-item"></select>
            <a href="javascript:;" data-toggle="tooltip" data-title="附件"><i class="fa fa-paperclip item" aria-hidden="true" name="attachment"></i></a>
            <a href="javascript:;" data-toggle="tooltip" data-title="模板"><i class="fa fa-tachometer last" name="template"></i></a>

        </div>

        <div class="editormd-group pull-right">
            <a href="javascript:;" data-toggle="tooltip" data-title="关闭实时预览"><i class="fa fa-eye-slash first" name="watch" unselectable="on"></i></a>
            <a href="javascript:;" data-toggle="tooltip" data-title="修改历史"><i class="fa fa-history item" name="history" aria-hidden="true"></i></a>
            <a href="javascript:;" data-toggle="tooltip" data-title="边栏"><i class="fa fa-columns item" aria-hidden="true" name="sidebar"></i></a>
            <a href="javascript:;" data-toggle="tooltip" data-title="使用帮助"><i class="fa fa-question-circle-o last" aria-hidden="true" name="help"></i></a>
        </div>

        <div class="editormd-group pull-right">
            <a href="javascript:;" data-toggle="tooltip" data-title="发布"><i class="fa fa-cloud-upload" name="release" aria-hidden="true"></i></a>
        </div>

        <div class="editor-group">
            <a href="javascript:;" data-toggle="tooltip" data-title=""></a>
            <a href="javascript:;" data-toggle="tooltip" data-title=""></a>
        </div>

        <div class="clearfix"></div>
    </div>
    <div class="manual-body">
        <div class="manual-category" id="manualCategory">
            <div class="manual-nav">
                <div class="nav-item active"><i class="fa fa-bars" aria-hidden="true"></i> 文档</div>
                <div class="nav-plus pull-right" id="btnAddDocument" data-toggle="tooltip" data-title="创建文档" data-direction="right"><i class="fa fa-plus" aria-hidden="true"></i></div>
                <div class="clearfix"></div>
            </div>
            <div class="manual-tree" id="sidebar"> </div>
        </div>
        <div class="manual-editor-container" id="manualEditorContainer">
            <div class="manual-editormd">
                <div id="docEditor" class="manual-editormd-active">
                    MinDoc 是一款针对IT团队开发的简单好用的文档管理系统。


                    MinDoc 的前身是 SmartWiki 文档系统。SmartWiki 是基于 PHP 框架 laravel 开发的一款文档管理系统。因 PHP 的部署对普通用户来说太复杂，所以改用 Golang 开发。可以方便用户部署和实用。

                    开发缘起是公司IT部门需要一款简单实用的项目接口文档管理和分享的系统。其功能和界面源于 kancloud 。

                    可以用来储存日常接口文档，数据库字典，手册说明等文档。内置项目管理，用户管理，权限管理等功能，能够满足大部分中小团队的文档管理需求。
                    <div contenteditable="false" class="editor-wrapper"><pre><code class="editor-code">f</code></pre></div>
                    <div><br/></div>
                </div>
            </div>
            <div class="manual-editor-status">
                <div id="attachInfo" class="item">0 个附件</div>
            </div>
        </div>

    </div>
</div>
<!--创建代码块的模态窗-->
<div class="modal fade" id="createCodeToolbarModal" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">创建链接</h4>
            </div>
            <div class="modal-body">
                <textarea></textarea>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="btnCreateCodeToolbar">确定</button>
            </div>
        </div>
    </div>
</div>

<!--创建链接的模态窗-->
<div class="modal fade" id="createLinkToolbarModal" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">创建链接</h4>
            </div>
            <div class="modal-body">
            <form class="form-horizontal">
                <div class="form-group">
                    <label for="linkUrl" class="control-label col-sm-2">链接地址</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="linkUrl" value="http://" data-url="">
                    </div>
                </div>
                <div class="form-group">
                    <label for="linkTitle" class="control-label col-sm-2">链接标题</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" value="" id="linkTitle" data-title="">
                    </div>
                </div>
            </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="btnCreateLinkToolbar">确定</button>
            </div>
        </div>
    </div>
</div>

<!-- 添加文档 -->
<div class="modal fade" id="addDocumentModal" tabindex="-1" role="dialog" aria-labelledby="addDocumentModalLabel">
    <div class="modal-dialog" role="document">
        <form method="post" action="{{urlfor "DocumentController.Create" ":key" .Model.Identify}}" id="addDocumentForm" class="form-horizontal">
            <input type="hidden" name="identify" value="{{.Model.Identify}}">
            <input type="hidden" name="doc_id" value="0">
            <input type="hidden" name="parent_id" value="0">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">添加文档</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">文档名称 <span class="error-message">*</span></label>
                        <div class="col-sm-10">
                            <input type="text" name="doc_name" id="documentName" placeholder="文档名称" class="form-control"  maxlength="50">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">文档标识</label>
                        <div class="col-sm-10">
                            <input type="text" name="doc_identify" id="documentIdentify" placeholder="文档唯一标识" class="form-control" maxlength="50">
                            <p style="color: #999;font-size: 12px;">文档标识只能包含小写字母、数字，以及“-”和“_”符号,并且只能小写字母开头</p>
                        </div>

                    </div>
                </div>
                <div class="modal-footer">
                    <span id="add-error-message" class="error-message"></span>
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="submit" class="btn btn-primary" id="btnSaveDocument" data-loading-text="保存中...">立即保存</button>
                </div>
            </div>
        </form>
    </div>
</div>
<!--附件上传-->
<div class="modal fade" id="uploadAttachModal" tabindex="-1" role="dialog" aria-labelledby="uploadAttachModalLabel">
    <div class="modal-dialog" role="document">
        <form method="post" id="uploadAttachModalForm" class="form-horizontal">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">上传附件</h4>
                </div>
                <div class="modal-body">
                    <div class="attach-drop-panel">
                        <div class="upload-container" id="filePicker"><i class="fa fa-upload" aria-hidden="true"></i></div>
                    </div>
                    <div class="attach-list" id="attachList">
                        <template v-for="item in lists">
                            <div class="attach-item" :id="item.attachment_id">
                                <template v-if="item.state == 'wait'">
                                    <div class="progress">
                                        <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100">
                                            <span class="sr-only">0% Complete (success)</span>
                                        </div>
                                    </div>
                                </template>
                                <template v-else-if="item.state == 'error'">
                                    <span class="error-message">${item.message}</span>
                                    <button type="button" class="btn btn-sm close" @click="removeAttach(item.attachment_id)">
                                        <i class="fa fa-remove" aria-hidden="true"></i>
                                    </button>
                                </template>
                                <template v-else>
                                    <a :href="item.http_path" target="_blank" :title="item.file_name">${item.file_name}</a>
                                    <span class="text">(${ formatBytes(item.file_size) })</span>
                                    <span class="error-message">${item.message}</span>
                                    <button type="button" class="btn btn-sm close" @click="removeAttach(item.attachment_id)">
                                        <i class="fa fa-remove" aria-hidden="true"></i>
                                    </button>
                                    <div class="clearfix"></div>
                                </template>
                            </div>
                        </template>
                    </div>
                </div>
                <div class="modal-footer">
                    <span id="add-error-message" class="error-message"></span>
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" id="btnUploadAttachFile" data-dismiss="modal">确定</button>
                </div>
            </div>
        </form>
    </div>
</div>
<!-- Modal -->
<div class="modal fade" id="documentHistoryModal" tabindex="-1" role="dialog" aria-labelledby="documentHistoryModalModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">文档历史记录</h4>
            </div>
            <div class="modal-body text-center" id="historyList">

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="documentTemplateModal" tabindex="-1" role="dialog" aria-labelledby="请选择模板类型" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="modal-title">请选择模板类型</h4>
            </div>
            <div class="modal-body template-list">
                <div class="container">
                    <div class="section">
                        <a data-type="normal" href="javascript:;"><i class="fa fa-file-o"></i></a>
                        <h3><a data-type="normal" href="javascript:;">普通文档</a></h3>
                        <ul>
                            <li>默认类型</li>
                            <li>简单的文本文档</li>
                        </ul>
                    </div>
                    <div class="section">
                        <a data-type="api" href="javascript:;"><i class="fa fa-file-code-o"></i></a>
                        <h3><a data-type="api" href="javascript:;">API文档</a></h3>
                        <ul>
                            <li>用于API文档速写</li>
                            <li>支持代码高亮</li>
                        </ul>
                    </div>
                    <div class="section">
                        <a data-type="code" href="javascript:;"><i class="fa fa-book"></i></a>

                        <h3><a data-type="code" href="javascript:;">数据字典</a></h3>
                        <ul>
                            <li>用于数据字典显示</li>
                            <li>表格支持</li>
                        </ul>
                    </div>
                </div>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>
<template id="template-normal">
{{template "document/template_normal.tpl"}}
</template>
<template id="template-api">
{{template "document/template_api.tpl"}}
</template>
<template id="template-code">
{{template "document/template_code.tpl"}}
</template>
<script src="{{cdnjs "/static/jquery/1.12.4/jquery.min.js"}}"></script>
<script src="{{cdnjs "/static/vuejs/vue.min.js"}}" type="text/javascript"></script>
<script src="{{cdnjs "/static/bootstrap/js/bootstrap.min.js"}}"></script>
<script src="{{cdnjs "/static/webuploader/webuploader.min.js"}}" type="text/javascript"></script>
<script src="{{cdnjs "/static/jstree/3.3.4/jstree.min.js"}}" type="text/javascript"></script>
{{/*<script src="/static/bootstrap/plugins/bootstrap-wysiwyg/external/jquery.hotkeys.js"></script>*/}}
{{/*<script src="/static/bootstrap/plugins/bootstrap-wysiwyg/bootstrap-wysiwyg.js" type="text/javascript"></script>*/}}
{{/*<script src="/static/bootstrap/plugins/bootstrap-wysiwyg/external/google-code-prettify/prettify.js"></script>*/}}
<script src="/static/katex/katex.min.js" type="text/javascript"></script>
<script src="/static/quill/quill.min.js" type="text/javascript"></script>
<script src="/static/quill/quill.icons.js"></script>
<script src="{{cdnjs "/static/layer/layer.js"}}" type="text/javascript" ></script>
<script src="{{cdnjs "/static/js/jquery.form.js"}}" type="text/javascript"></script>
{{/*<script src="/static/js/editor.js" type="text/javascript"></script>*/}}

<script type="text/javascript">

    var quill = new Quill('#docEditor', {
        theme: 'snow',
        modules : {
            toolbar :"#editormd-tools"
        }
    });

    $(function () {
        var $editorEle =  $("#editormd-tools");

        $editorEle.find(".ql-undo").on("click",function () {
           quill.history.undo();
        });
        $editorEle.find(".ql-redo").on("click",function () {
            quill.history.redo();
        });

        //弹出创建链接的对话框
        $("#createLinkToolbar").on("click",function () {
            $("#createLinkToolbarModal").modal("show");
        });
        /**
         * 当点击创建链接按钮后
         */
        $("#btnCreateLinkToolbar").on("click",function () {

            var $then = $("#createLinkToolbarModal");
            var link = $then.find("input[data-url]").val();
            var title = $then.find("input[data-title]").val();
            if(link === ""){
                alert("链接地址不能为空");
                return false;
            }else if(title === ""){
                alert("链接标题不能为空");
                return false;
            }

            $then.modal("hide");
            window.wysiwyg.insertLink(link,title);
        });
        /**
         * 创建代码块弹窗
         */
        $("#createCodeToolbar").on("click",function () {
           $("#createCodeToolbarModal").modal("show");
        });
        /**
         * 插入代码块
         */
        $("#btnCreateCodeToolbar").on("click",function () {
            var $then = $("#createCodeToolbarModal");
            var code = $then.find("textarea").val();
            console.log(code)
            var codeHtml = '<div contenteditable="false" class="editor-wrapper"><code class="editor-code">' + code + '</code></div><p></p>';
            $then.modal("hide");
            window.wysiwyg.insertHtml(codeHtml);
        });
        $(".editor-code").on("dblclick",function () {
            var code = $(this).html();
            $("#createCodeToolbarModal").find("textarea").val(code);
            $("#createCodeToolbarModal").modal("show");
        }).on("click",function (e) {
            e.preventDefault();
            e.stopPropagation();
            console.log($(this).parents(".editor-wrapper").html())
            $(this).parents(".editor-wrapper").addClass("editor-wrapper-selected");
        });

        $("#attachInfo").on("click",function () {
            $("#uploadAttachModal").modal("show");
        });
        window.uploader = null;


        $("#uploadAttachModal").on("shown.bs.modal",function () {
            if(window.uploader === null){
                try {
                    window.uploader = WebUploader.create({
                        auto: true,
                        dnd : true,
                        swf: '/static/webuploader/Uploader.swf',
                        server: '{{urlfor "DocumentController.Upload"}}',
                        formData : { "identify" : {{.Model.Identify}},"doc_id" :  window.selectNode.id },
                        pick: "#filePicker",
                        fileVal : "editormd-file-file",
                        fileNumLimit : 1,
                        compress : false
                    }).on("beforeFileQueued",function (file) {
                        uploader.reset();
                        this.options.formData.doc_id = window.selectNode.id;
                    }).on( 'fileQueued', function( file ) {
                        var item = {
                            state : "wait",
                            attachment_id : file.id,
                            file_size : file.size,
                            file_name : file.name,
                            message : "正在上传"
                        };
                        window.vueApp.lists.splice(0,0,item);

                    }).on("uploadError",function (file,reason) {
                        for(var i in window.vueApp.lists){
                            var item = window.vueApp.lists[i];
                            if(item.attachment_id == file.id){
                                item.state = "error";
                                item.message = "上传失败";
                                break;
                            }
                        }

                    }).on("uploadSuccess",function (file, res) {

                        for(var index in window.vueApp.lists){
                            var item = window.vueApp.lists[index];
                            if(item.attachment_id === file.id){
                                if(res.errcode === 0) {
                                    window.vueApp.lists.splice(index, 1, res.attach);

                                }else{
                                    item.message = res.message;
                                    item.state = "error";
                                }
                                break;
                            }
                        }

                    }).on("beforeFileQueued",function (file) {

                    }).on("uploadComplete",function () {

                    }).on("uploadProgress",function (file, percentage) {
                        var $li = $( '#'+file.id ),
                                $percent = $li.find('.progress .progress-bar');

                        $percent.css( 'width', percentage * 100 + '%' );
                    });
                }catch(e){
                    console.log(e);
                }
            }
        });
    });
</script>
</body>
</html>