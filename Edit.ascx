﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Edit.ascx.cs" Inherits="FortyFingers.SeoRedirect.Edit" %>
<%@ Import Namespace="FortyFingers.SeoRedirect.Components" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke.Web" Namespace="DotNetNuke.Web.UI.WebControls" %>

<script type="text/javascript">
    ff_seo_selectedPageChanged = function (selectedNode, arg2) {
        // no way to figure out which textbox to clear
        //console.log(JSON.stringify(selectedNode));
        FF.log("triggering change on : " + $("#" + arg2[0].previousElementSibling.id).attr('id'));

        $("#" + arg2[0].previousElementSibling.id).trigger('change');
    };

</script>
<script type="text/javascript">
    var srPid = <%= PortalId %>;
    var srMid = <%= ModuleId %>;
    var srVM;
    $(document).ready(function () {
        SR.service = $.ServicesFramework(srMid);
        SR.service.baseUrl = SR.service.getServiceRoot("40Fingers") + "SeoRedirect/";

        srVM = new SR.MappingsVm({ urls: [] });
        srVM.load();
    });
</script>

<div class="ffsr ffsr-edit">
    <div id="koEditMappingsWrapper">
        <div class="loader" data-bind="visible: isLoading"></div>
        <table class="dnnGrid">
            <thead>
                <tr class="dnnGridHeader">
                    <th><%= Localization.GetString("SourceUrlHeaderLabel", LocalResourceFile) %></th>
                    <th><%= Localization.GetString("TargetUrlHeaderLabel", LocalResourceFile) %></th>
                    <th><img class="imgShowEditMapping" data-bind="click: addMapping" src="<%= Icons.GetUrl(IconTypes.Add) %>" /></th>
                </tr>
            </thead>
            <tbody data-bind="foreach: mappings">
                <tr class="dnnGridItem ffsr-item">
                    <td><a target="_new"><span data-bind="text: sourceUrl"></span></a></td>
                    <td><span data-bind="text: targetUrl"></span></td>
                    <td>
                        <a href="#" data-bind="click: toggleEditMappingPanel">
                            <img class="imgShowEditMapping" data-bind="attr: {id: 'showEditMapping_' + $index()}" src="<%= Icons.GetUrl(IconTypes.Add) %>" />
                            <img class="imgHideEditMapping hidden" data-bind="attr: {id: 'hideEditMapping_' + $index()}" src="<%= Icons.GetUrl(IconTypes.Cancel) %>" />
                        </a>
                    </td>
                </tr>
                <tr class="ffsr-edit ffrs-editMappingPanel hidden" data-bind="attr: {id: 'editMappingPanel_' + $index()} ">
                    <td colspan="3">
                        <div class="loader" data-bind="visible: isLoading"></div>
                        <div class="dnnForm">
                            <div class="dnnFormItem">
                                <div>
                                    <%= Localization.GetString("SourceUrlHeaderLabel", LocalResourceFile) %>
                                </div>
                                <input type="text" data-bind="value: sourceUrl, attr: {id: 'sourceUrl_' + $index(), name: 'sourceUrl_' + $index()} " />
                            </div>
                            <div class="dnnFormItem">
                                <div><%= Localization.GetString("UseRegexHeaderLabel", LocalResourceFile) %></div>
                                <input type="checkbox" value="true" data-bind="checked: useRegex" />
                            </div>
                            <div class="dnnFormMessage dnnFormValidationSummary" data-bind="visible: targetTabId() > 0 && targetTabName() === ''">
                                <div>
                                    <%= Localization.GetString("RedirectTabNotFound", LocalResourceFile) %>
                                </div>
                            </div>
                            <div class="dnnFormItem">
                                <div>
                                    <input type="radio" data-bind="checked: mapToType, attr: {name: 'mapToTypeRadio_' + $index()}" value="URL" /><%= Localization.GetString("RedirectToUrl", LocalResourceFile) %>
                                </div>
                                <input type="text" data-bind="value: targetUrl, attr: {id: 'redirectUrl_' + $index(), name: 'redirectUrl_' + $index()}, event: { change: mapToType('URL') }" />
                            </div>
                            <div class="dnnFormItem" data-bind="attr: {id: 'redirectPageDropdown_' + $index()} ">
                                <div>
                                    <input type="radio" data-bind="checked: mapToType, attr: {name: 'mapToTypeRadio_' + $index()}" value="TAB" /><%= Localization.GetString("RedirectToTabId", LocalResourceFile) %>
                                </div>
                                <div class="page dnnDropDownList" data-bind="attr: {id: 'createPageDropdown_' + $index()}">
                                    <div class="selected-item">
                                        <a href="javascript:void(0);" title="Click to expand" class="selected-value">Select A Web Page</a>
                                    </div>
                                    <input type="hidden" data-bind="attr: {id: 'createPageDropdownState_' + $index()}, event: { change: setSelectedTab }" />
                                </div>
                            </div>
                            <div class="dnnFormItem">
                                <div>
                                    <input type="radio" data-bind="checked: mapToType, attr: {name: 'mapToTypeRadio_' + $index()}" value="NONE" /><%= Localization.GetString("NoRedirect", LocalResourceFile) %>
                                </div>
                                <span>&nbsp;</span>
                            </div>
                        </div>
                        <ul class="dnnActions dnnClear">
                            <li><a class="dnnPrimaryAction" data-bind="click: saveMapping">Save</a></li>
                            <li><a class="dnnSecondaryAction" data-bind="click: toggleEditMappingPanel">Cancel</a></li>
                        </ul>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>

</div>
