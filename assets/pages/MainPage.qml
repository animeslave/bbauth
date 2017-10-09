/*
 * Copyright (c) 2011-2015 BlackBerry Limited.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import bb.cascades 1.4

NavigationPane {
    id: navigationPane
    Menu.definition: MenuDefinition {
        settingsAction: SettingsActionItem {
            onTriggered: {
                navigationPane.push(settingsPageDef.createObject());
            }
        }
        helpAction: HelpActionItem {
        }
    }
    Page {
        id: mainPage
        content: Container {
            layout: DockLayout {
            }
            ListView {
                id: listView
                verticalAlignment: VerticalAlignment.Fill
                horizontalAlignment: HorizontalAlignment.Fill
                //dataModel: _app.dataModel
                dataModel: XmlDataModel {
                    source: "asset:///model.xml"
                }
                listItemComponents: [
                    ListItemComponent {
                        type: "item"
                        content: Container {
                            Container {
                                Container {
                                    Container {
                                        layoutProperties: StackLayoutProperties {
                                            spaceQuota: 1.0

                                        }
                                        verticalAlignment: VerticalAlignment.Center
                                        Container {
                                            Label {
                                                text: ListItemData.title
                                                textStyle.fontSize: FontSize.Medium
                                            }
                                        }
                                        Container {
                                            Label {
                                                text: ListItemData.auth_login
                                                textStyle.fontSize: FontSize.XSmall
                                                textStyle.color: Color.DarkGray
                                                textStyle.fontWeight: FontWeight.W300
                                            }
                                        }
                                    }
                                    Container {
                                        verticalAlignment: VerticalAlignment.Center
                                        layout: StackLayout {

                                        }
                                        layoutProperties: StackLayoutProperties {
                                            spaceQuota: 1.0

                                        }
                                        horizontalAlignment: HorizontalAlignment.Right
                                        Label {
                                            text: ListItemData.auth_code
                                            horizontalAlignment: HorizontalAlignment.Right
                                            textStyle.fontSize: FontSize.XLarge

                                        }
                                    }
                                    layout: StackLayout {
                                        orientation: LayoutOrientation.LeftToRight
                                    }
                                    leftPadding: ui.du(1.4)
                                    rightPadding: leftPadding
                                }
                                Container {
                                    topPadding: ui.du(0.6)
                                    Divider{
                                    }
                                }
                            }
                        }
                    }
                ]
                property variant activeItem: undefined
                onActivationChanged: {
                    if (active) activeItem = indexPath; //[0]
                }
                snapMode: SnapMode.LeadingEdge
            }
            ProgressIndicator {
                verticalAlignment: VerticalAlignment.Bottom
            }
            contextActions: [
                ActionSet {
                    title: qsTr("Authenticator Code")
                    subtitle: ListItemData.title
                    MultiSelectActionItem {
                    }
                    DeleteActionItem {
                        title: qsTr("Delete This Entry")
                        onTriggered: {
                            //Qt.dlg.body = qsTr("Are you sure to delete account: %0?").arg(ListItemData.email)
                            //Qt.dlg.show()
                        }
                    }
                }
            ]
        }
        actions: [
            ActionItem {
                id: scanQRCodeButton
                title: qsTr("Scan QR") + Retranslate.onLocaleOrLanguageChanged
                imageSource: "asset:///images/icons/ic_scan_barcode.png"
                ActionBar.placement: ActionBarPlacement.Signature
                shortcuts: Shortcut {
                    key: "S"
                }
                onTriggered: {
                    navigationPane.push(scanQRCodePageDef.createObject());
                }
            },
            ActionItem {
                id: addCodeButton
                title: qsTr("Add code") + Retranslate.onLocaleOrLanguageChanged
                imageSource: "asset:///images/icons/ic_rename.png"
                ActionBar.placement: ActionBarPlacement.OnBar
                shortcuts: Shortcut {
                    key: "A"
                }
                onTriggered: {
                    var page = addCodePageDef.createObject();
                    page.open();
                }
            },
            MultiSelectActionItem {}
        ]
    }
    attachedObjects: [
        ComponentDefinition {
            id: settingsPageDef
            source: "SettingsPage.qml"
        },
        ComponentDefinition {
            id: scanQRCodePageDef
            source: "ScanQRCodePage.qml"
        },
        ComponentDefinition {
            id: addCodePageDef
            content: Sheet {
                id: addCodeSheet
                AddCodePage {
                }
            }
        }
    ]
    
    onPopTransitionEnded: page.destroy();
    onCreationCompleted: {
        //Application.themeSupport.setVisualStyle(_settings.visualStyle);
    }
}