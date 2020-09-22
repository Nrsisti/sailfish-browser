/****************************************************************************
**
** Copyright (C) 2020 Open Mobile Platform LLC
**
****************************************************************************/

/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this file,
 * You can obtain one at http://mozilla.org/MPL/2.0/. */

import QtQuick 2.0
import Sailfish.Silica 1.0
import Sailfish.Browser 1.0

Page {
    property string searchText

    BookmarkModel { id: bookmarkModel }

    BookmarkFilterModel {
        id: bookmarkFilterModel
        sourceModel: bookmarkModel
        search: searchText
    }

    Column {
        id: column
        width: parent.width
        PageHeader {
            //% "Bookmarks"
            title: qsTrId("sailfish_browser-he-bookmarks")
        }
        SearchField {
            width: parent.width
            //% "Search"
            placeholderText: qsTrId("sailfish_browser-ph-search")
            EnterKey.onClicked: focus = false
            onTextChanged: searchText = text
        }
    }

    SilicaListView {
        id: listView

        clip: true

        width: parent.width
        anchors {
            bottom: parent.bottom
            top: column.bottom
        }

        model: bookmarkFilterModel

        delegate: BookmarkItem { width: listView.width }

        ViewPlaceholder {
            //% "Bookmarks that you save will show up here"
            text: qsTrId("sailfish_browser-la-bookmarks-show-up-here")
            enabled: bookmarkModel.count === 0
        }

        VerticalScrollDecorator {
            parent: listView
            flickable: listView
        }
    }
}