import QtQuick 2.1
import QtQuick.Layouts 1.15
import org.kde.kirigami 2.12 as Kirigami
import QtQuick.Controls 2.0 as Controls

Kirigami.ApplicationWindow {
    id: root

    title: i18n("podkaster")

    globalDrawer: Kirigami.GlobalDrawer {
        title: i18n("podkaster")
        titleIcon: "applications-graphics"
        actions: [
            Kirigami.Action {
                text: i18n("Episodes")
                onTriggered: {
                    pageStack.clear(); 
                    pageStack.push(episodesPageComponent);
                }
            },
            Kirigami.Action {
                text: i18n("Subscriptions")
                onTriggered: {
                    pageStack.clear();
                    pageStack.replace(subscriptionsPageComponent);
                }
            },
            Kirigami.Action {
                text: i18n("Discover")
                onTriggered: {
                    pageStack.clear();
                    pageStack.replace(discoverPageComponent);
                }
            }
        ]
    }

    contextDrawer: Kirigami.ContextDrawer {
        id: contextDrawer
    }

    pageStack.initialPage: episodesPageComponent

    Component {
        id: episodesPageComponent

        Kirigami.ScrollablePage {
            title: i18n("Episodes")
            
            supportsRefreshing: true
            onRefreshingChanged: {
                if (refreshing) {
                    console.log("Refreshing episodes")
                }
            }
            
            Kirigami.CardsListView {
                id: episodesListView
                Kirigami.PlaceholderMessage {
                    anchors.centerIn: parent
                    width: parent.width - (Kirigami.Units.largeSpacing * 4)
                    visible: episodesListView.count === 0
                    helpfulAction: Kirigami.Action {
                        text: i18n("Discover Podcasts")
                        onTriggered: {
                            pageStack.clear();
                            pageStack.replace(discoverPageComponent);
                        }
                    }
                }
                model: 0
                delegate: Kirigami.AbstractCard {
                    contentItem: Item {
                        implicitWidth: delegateLayout.implicitWidth
                        implicitHeight: delegateLayout.implicitHeight
                        GridLayout {
                            id: delegateLayout
                            anchors {
                                left: parent.left
                                top: parent.top
                                right: parent.right
                            }
                            rowSpacing: Kirigami.Units.largeSpacing
                            columnSpacing: Kirigami.Units.largeSpacing
                            columns: width > Kirigami.Units.gridUnit * 20 ? 4 : 2
                            Kirigami.Icon {
                                Layout.fillHeight: true
                                Layout.maximumHeight: Kirigami.Units.iconSizes.huge
                                Layout.preferredWidth: height
                            }
                            Kirigami.Heading {
                                level: 2
                                text: modelData
                            }
                        }
                    }
                }
            }
        }
    }
    
    Component {
        id: episodePageComponent

        Kirigami.Page {
            title: i18n("Episode")
        }
    }
 
    Component {
        id: subscriptionsPageComponent
        
        Kirigami.ScrollablePage {
            title: i18n("Subscriptions")
            
            Kirigami.CardsListView {
                id: episodesListView
                Kirigami.PlaceholderMessage {
                    anchors.centerIn: parent
                    width: parent.width - (Kirigami.Units.largeSpacing * 4)
                    visible: episodesListView.count === 0
                    helpfulAction: Kirigami.Action {
                        text: i18n("Discover Podcasts")
                        onTriggered: {
                            pageStack.clear();
                            pageStack.replace(discoverPageComponent);
                        }
                    }
                }
                model: 0
                delegate: Kirigami.AbstractCard {
                    contentItem: Item {
                        implicitWidth: delegateLayout.implicitWidth
                        implicitHeight: delegateLayout.implicitHeight
                        GridLayout {
                            id: delegateLayout
                            anchors {
                                left: parent.left
                                top: parent.top
                                right: parent.right
                            }
                            rowSpacing: Kirigami.Units.largeSpacing
                            columnSpacing: Kirigami.Units.largeSpacing
                            columns: width > Kirigami.Units.gridUnit * 20 ? 4 : 2
                            Kirigami.Icon {
                                Layout.fillHeight: true
                                Layout.maximumHeight: Kirigami.Units.iconSizes.huge
                                Layout.preferredWidth: height
                            }
                            Kirigami.Heading {
                                level: 2
                                text: modelData
                            }
                        }
                    }
                }
            }
        }
    }
 
    Component {
        id: podcastPageComponent

        Kirigami.Page {
            title: i18n("Podcast")
        }
    }
  
    Component {
        id: discoverPageComponent

        Kirigami.Page {
            title: i18n("Discover")
            
            Kirigami.CardsLayout {
                Kirigami.Card {
                    actions: [
                        Kirigami.Action {
                            checkable: true
                            text: i18n("Subscribe")
                            onTriggered: {
                                if(text == i18n("Subscribe")) {
                                    text = i18n("Subscribed");
                                    checked = true;
                                    showPassiveNotification(i18n("Subscribed to The foss-north pod"));
                                } else {
                                    text = i18n("Subscribe");
                                    checked = false;
                                    showPassiveNotification(i18n("Unsubscribed from The foss-north pod"));
                                }
                            }
                        },
                        Kirigami.Action {
                            text: i18n("Visit")
                        },
                        Kirigami.Action {
                            text: i18n("More...")
                            onTriggered: pageStack.push(episodePageComponent)
                        }
                    ]
                    banner {
                        title: "The foss-north pod"
                    }
                    contentItem: Controls.Label {
                        text: "bla bla bla"
                    }
                }
            }
        }
    }
}
