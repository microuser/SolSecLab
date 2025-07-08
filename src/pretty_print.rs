use std::fs;
use std::io::{Read, Write};
use std::path::Path;
use html5ever::tendril::TendrilSink;
use html5ever::parse_document;
use markup5ever_rcdom::RcDom;
use html5ever::serialize::{serialize, SerializeOpts};
use markup5ever_rcdom::SerializableHandle;

fn main() {
    let path = Path::new("public/index.html");
    let mut file = fs::File::open(&path).expect("Failed to open index.html");
    let mut html = String::new();
    file.read_to_string(&mut html).expect("Failed to read index.html");

    // Parse the HTML
    let dom = parse_document(RcDom::default(), Default::default())
        .from_utf8()
        .read_from(&mut html.as_bytes())
        .expect("Failed to parse HTML");

    // Serialize the DOM (no true pretty print, but normalizes structure)
    let mut pretty_html = Vec::new();
    serialize(
        &mut pretty_html,
        &SerializableHandle::from(dom.document.clone()),
        SerializeOpts::default(),
    )
    .expect("Failed to serialize HTML");

    // Write back to the file
    let mut file = fs::File::create(&path).expect("Failed to open index.html for writing");
    file.write_all(&pretty_html).expect("Failed to write pretty HTML");
    println!("Formatted public/index.html");
}
