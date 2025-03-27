use dioxus::prelude::*;

#[component]
pub fn Games() -> Element {
    rsx! {
        section { id: "games", class: "games-section",
            h2 { "Games" }
            div { class: "games-grid",
                GameCard {
                    icon: "gamepad",
                    title: "Game Title 1",
                    description: "简短的游戏描述",
                    play_ref: "/games/game1",
                    code_ref: "/games/game1/code",
                }
                GameCard {
                    icon: "chess",
                    title: "Game Title 2",
                    description: "简短的游戏描述",
                    play_ref: "/games/game2",
                }
            }
        }
    }
}

#[component]
fn GameCard(
    icon: String,
    title: String,
    description: String,
    play_ref: String,
    code_ref: Option<String>,
) -> Element {
    rsx! {
        div { class: "game-card",
            div { class: "game-thumbnail",
                i { class: "fas fa-{icon}" }
            }
            div { class: "game-info",
                h3 { "{title}" }
                p { "{description}" }
                div { class: "game-links",
                    a { href: "{play_ref}", class: "play-button", "Play Now" }
                    if let Some(code_ref) = code_ref {
                        a { href: "{code_ref}", class: "code-button", "View Code" }
                    }
                }
            }
        }
    }
}
