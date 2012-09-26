/****************************************************************************
**
** Copyright (C) 2012 Digia Plc and/or its subsidiary(-ies).
** Contact: http://qt-project.org/legal
**
** This file is part of the QtCore module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:LGPL$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and Digia.  For licensing terms and
** conditions see http://qt.digia.com/licensing.  For further information
** use the contact form at http://qt.digia.com/contact-us.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 2.1 as published by the Free Software
** Foundation and appearing in the file LICENSE.LGPL included in the
** packaging of this file.  Please review the following information to
** ensure the GNU Lesser General Public License version 2.1 requirements
** will be met: http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
**
** In addition, as a special exception, Digia gives you certain additional
** rights.  These rights are described in the Digia Qt LGPL Exception
** version 1.1, included in the file LGPL_EXCEPTION.txt in this package.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 3.0 as published by the Free Software
** Foundation and appearing in the file LICENSE.GPL included in the
** packaging of this file.  Please review the following information to
** ensure the GNU General Public License version 3.0 requirements will be
** met: http://www.gnu.org/copyleft/gpl.html.
**
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.0
import QtWebKit 3.0
import QtQuick.XmlListModel 2.0
import "../shared"

Rectangle {
    id: container
    width: 1024
    height: 768

    property string initialUrl: "https://www.flickr.com/explore/interesting/7days/?"

    Rectangle {
        id: thumbnailContainer
        color: "black"

        anchors.bottom: container.bottom
        width: container.width
        height: 100

        gradient: Gradient {
            GradientStop { position: 0.0; color: "gray" }
            GradientStop { position: 0.33; color: "black" }
        }

        Text {
            id: info
            color: "white"
            anchors.horizontalCenter: thumbnailContainer.horizontalCenter
            text: webView.title
        }

        ListView {
            id: listView
            orientation: "Horizontal"
            anchors {
                topMargin: 20
                fill: parent
            }

            model: model
            delegate: Component {
                Image {
                    source: thumbnail
                    MouseArea {
                        anchors.fill: parent
                        onClicked: webView.url = link + "/lightbox"
                    }
                }
            }

            focus: true
            spacing: 10
            leftMargin: 10
            rightMargin: 35
            visible: model.status == XmlListModel.Ready
        }

        Rectangle {
            id: updateInfo

            property real distance: -(listView.contentWidth - listView.contentX - thumbnailContainer.width)
            property real threshold: Math.max(2.5 * listView.height, thumbnailContainer.width - listView.contentWidth + 2 * listView.height)
            property bool triggerUpdate: false

            opacity: 0.8
            x: thumbnailContainer.width - distance
            width: listView.height
            color: "transparent"

            anchors {
                top: thumbnailContainer.top
                bottom: thumbnailContainer.bottom
            }

            Timer {
                interval: 200; running: updateInfo.state == "update"; repeat: false
                onTriggered: { model.reload(); updateInfo.triggerUpdate = false; }
            }

            states: [
                State {
                    name: "pull"
                    when: updateInfo.distance <= updateInfo.threshold && listView.dragging
                    PropertyChanges { target: message; text: "Pull\nto\nupdate" }
                },

                State {
                    name: "release"
                    when: updateInfo.distance > updateInfo.threshold && listView.dragging
                    PropertyChanges { target: message; text: "Release\nto\nupdate" }
                },

                State {
                    name: "update"
                    when: updateInfo.triggerUpdate && listView.atXEnd && !listView.dragging
                    PropertyChanges { target: message; text: "Updating" }
                }
            ]

            onStateChanged: {
                if (state == "release")
                    triggerUpdate = true
                if (state == "pull")
                    triggerUpdate = false
            }

            Rectangle {
                id: icon
                width: 30
                color: "transparent"
                anchors {
                    topMargin: 10
                    top: parent.top
                    bottom: parent.bottom
                    left: parent.left
                }
                Image {
                    source: "../shared/images/arrow.png"
                    width: 30
                    height: 30
                    visible: updateInfo.state != "update"
                    rotation: updateInfo.state == "release" ? 180 : 0
                    Behavior on rotation { NumberAnimation { duration: 100} }
                    SequentialAnimation on x {
                        running: listView.atXEnd && !listView.dragging
                        loops: Animation.Infinite
                        PropertyAnimation { to: 5; duration: 250 }
                        PropertyAnimation { to: 0; duration: 250 }
                    }
                    anchors {
                        verticalCenter: parent.verticalCenter
                    }
                }
            }

            Text {
                id: message
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.family: "Monospace"
                color: "white"
                anchors {
                    top: parent.top
                    bottom: parent.bottom
                    right: parent.right
                    left: icon.right
                }
            }
        }

        LoadIndicator {
            anchors.fill: parent
            color: "black"
            running: !listView.visible && model.status != XmlListModel.Error
        }
    }

    Rectangle {
        id: content
        width: container.width
        color: "black"
        anchors {
            top: container.top
            bottom: thumbnailContainer.top
        }

        WebView {
            id: webView
            anchors.fill: parent
            opacity: 0

            url: container.initialUrl

            Behavior on opacity {
                NumberAnimation { duration: 200 }
            }

            onLoadingChanged: {
                switch (loadRequest.status)
                {
                case WebView.LoadSucceededStatus:
                    opacity = 1
                    break
                default:
                    opacity = 0
                    break
                }
            }

            onNavigationRequested: {
                var pattern = new RegExp('^(https|http)://www.flickr.com|^(https|http)://login.yahoo.com');
                switch (request.navigationType)
                {
                case WebView.LinkClickedNavigation:
                case WebView.FormSubmittedNavigation:
                case WebView.BackForwardNavigation:
                case WebView.ReloadNavigation:
                case WebView.FormResubmittedNavigation:
                case WebView.OtherNavigation:
                    if (pattern.test(request.url)) {
                        request.action = WebView.AcceptRequest
                        return
                    }
                }
                // Disallow navigating outside of flickr.com
                request.action = WebView.IgnoreRequest
            }
        }

        LoadIndicator {
            anchors.fill: parent
            imageSource: "images/flickr.png"
            running: webView.loading
        }
    }

    XmlListModel {
        id: model
        namespaceDeclarations: "declare namespace media=\"http://search.yahoo.com/mrss/\";"
        source: "http://api.flickr.com/services/feeds/photos_public.gne?format=rss2"
        query: "/rss/channel/item"
        XmlRole { name: "thumbnail"; query: "media:thumbnail/@url/string()" }
        XmlRole { name: "thumbnailHeight"; query: "media:thumbnail/@height/number()" }
        XmlRole { name: "content"; query: "media:content/@url/string()" }
        XmlRole { name: "link"; query: "link/string()" }
    }

}
