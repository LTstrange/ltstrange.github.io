use dioxus::prelude::*;

#[component]
pub fn Projects() -> Element {
    rsx! {
        section { id: "projects", class: "projects",
            h2 { "Projects" }
            div { class: "project-grid",
                ProjectCard {
                    code_ref: "https://github.com/LTstrange/satellite-simulator",
                    img: asset!("/assets/projects/satellite.png"),
                    title: "Satellite Simulator",
                    description: "A satellite simulator built on the Bevy engine",
                    tags: vec!["Python", "Rust", "Bevy", "Satellites"]
                        .into_iter()
                        .map(str::to_string)
                        .collect(),
                }
                ProjectCard {
                    code_ref: "https://github.com/LTstrange/SirenLanguage",
                    img: asset!("/assets/projects/sirenlanguage.png"),
                    title: "Siren Project",
                    description: "This is a project to build and design my own programming language, called Siren language.",
                    tags: vec!["Rust", "AST", "Compiler"].into_iter().map(str::to_string).collect(),
                }
                ProjectCard {
                    code_ref: "https://github.com/LTstrange/SimpleBNF",
                    img: asset!("/assets/projects/project.png"),
                    title: "Simple BNF",
                    description: "This is the project I'm trying to make my own BNF parser tool in pure python.",
                    tags: vec!["Python", "BNF"].into_iter().map(str::to_string).collect(),
                }
                ProjectCard {
                    code_ref: "https://github.com/LTstrange/MCTScontinue",
                    img: asset!("/assets/projects/gobang-game-board.jpeg"),
                    title: "MCTS on Gobang",
                    description: "This is a project use Monte Carlo Tree Search to play Gobang.",
                    tags: vec!["Rust", "MCTS", "AI", "Multi-threading"]
                        .into_iter()
                        .map(str::to_string)
                        .collect(),
                }
            }
        }
    }
}

#[component]
fn ProjectCard(
    code_ref: String,
    img: Option<Asset>,
    title: String,
    description: String,
    tags: Vec<String>,
) -> Element {
    rsx! {
        a { class: "project-card", href: code_ref, target: "_blank",
            div { class: "project-image",
                if let Some(img) = img {
                    img { src: img }
                } else {
                    i {
                        class: "fas fa-project-diagram",
                        style: "font-size: 3rem; color: var(--primary);",
                    }
                }
            }
            div { class: "project-info",
                h3 { "{title}" }
                p { "{description}" }
                div { class: "project-tags",
                    for tag in tags {
                        span { class: "tag", "{tag}" }
                    }
                }
            }
        }
    }
}
