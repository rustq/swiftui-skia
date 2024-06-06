extern crate soft_skia;
extern crate base64;
use soft_skia::instance::Instance;
use soft_skia::shape::Line;
use soft_skia::shape::PaintStyle;
use soft_skia::shape::Rect;
use soft_skia::shape::Circle;
use soft_skia::shape::Shapes;
use soft_skia::shape::Pixmap;

#[swift_bridge::bridge]
mod ffi {
    extern "Rust" {
        type SoftSkia;

        #[swift_bridge(init)]
        fn new() -> SoftSkia;

        fn create(&mut self, id: usize) -> ();
        // fn add(parent_id: usize, child_id: usize) -> ();
        fn set_attr(&mut self, id: usize, x: u32, y: u32, width: u32, height: u32, r: u32, g: u32, b: u32, shape: String);
        fn to_base64(&mut self) -> String;

        fn hello_rust() -> String;
        fn hello_soft_skia() -> String;
    }
}

pub struct SoftSkia {
    instance: Instance
}

impl SoftSkia {
    pub fn new() -> Self {
        let mut instance = Instance::new(0);
        instance.set_shape_to_child(
            0,
            Shapes::R(Rect {
                x: 0,
                y: 0,
                width: 400,
                height: 400,
                color: None,
                style: None,
            }),
        );
        Self {
            instance
        }
    }

    pub fn create(&mut self, id: usize) -> () {
        self.instance.create_child_append_to_container(id, 0);
    }

    pub fn add(parent_id: usize, child_id: usize) -> () {
        todo!()
    }

    pub fn set_attr(&mut self, id: usize, x: u32, y: u32, width: u32, height: u32, r: u32, g: u32, b: u32, shape: String) {
        match shape.as_str() {
            "rect" => {
                self.instance.set_shape_to_child(id, Shapes::R(Rect {
                    x,
                    y,
                    width,
                    height,
                    color: Some(soft_skia::shape::ColorU8::from_rgba(r as u8, g as u8, b as u8, 255)),
                    style: None,
                }))
            },
            "line" => {
                self.instance.set_shape_to_child(id, Shapes::L(Line {
                    p1: [x, y],
                    p2: [x + 100, y + 100],
                    color: Some(soft_skia::shape::ColorU8::from_rgba(r as u8, g as u8, b as u8, 255)),
                    stroke_width: Some(4),
                }))
            },
            _ => {
                
            }
        }
    }

    pub fn to_base64(&mut self) -> String {
        to_base64(&mut self.instance.tree)
    }
}

fn hello_rust() -> String {
    String::from("Hello from Rust!")
}

fn hello_soft_skia() -> String {

    let mut instance = Instance::new(0);
    instance.create_child_append_to_container(1, 0);
    instance.create_child_append_to_container(2, 0);
    instance.create_child_append_to_container(3, 0);
    instance.create_child_append_to_container(4, 0);

    instance.set_shape_to_child(
        0,
        Shapes::R(Rect {
            x: 0,
            y: 0,
            width: 400,
            height: 400,
            color: None,
            style: None,
        }),
    );

    instance.set_shape_to_child(
        1,
        Shapes::R(Rect {
            x: 20,
            y: 20,
            width: 200,
            height: 200,
            color: Some(soft_skia::shape::ColorU8::from_rgba(0, 100, 0, 255)),
            style: None,
        }),
    );

    instance.set_shape_to_child(
        2,
        Shapes::C(Circle {
            cx: 120,
            cy: 120,
            r: 40,
            color: Some(soft_skia::shape::ColorU8::from_rgba(40, 0, 40, 255)),
            style: None,
        }),
    );

    instance.set_shape_to_child(
        3,
        Shapes::R(Rect {
            x: 300,
            y: 300,
            width: 60,
            height: 80,
            color: Some(soft_skia::shape::ColorU8::from_rgba(255, 0, 0, 255)),
            style: None,
        }),
    );

    instance.set_shape_to_child(
        4,
        Shapes::R(Rect {
            x: 300,
            y: 100,
            width: 60,
            height: 80,
            color: Some(soft_skia::shape::ColorU8::from_rgba(255, 255, 255, 255)),
            style: None,
        }),
    );

    to_base64(&mut instance.tree)
}


pub fn to_base64(tree: &mut soft_skia::tree::Tree) -> String {
    let root = tree.get_root();
    let mut pixmap = match root.shape {
        Shapes::R(Rect {
            x,
            y,
            width,
            height,
            color,
            style,
        }) => Pixmap::new(width, height).unwrap(),
        _ => Pixmap::new(0, 0).unwrap(),
    };

    recursive_rasterization_node_to_pixmap(root, &mut pixmap);

    let data = pixmap.clone().encode_png().unwrap();
    let data_url = base64::encode(&data);
    format!("data:image/png;base64,{}", data_url)
}

fn recursive_rasterization_node_to_pixmap(node: &mut soft_skia::tree::Node, pixmap: &mut Pixmap) -> () {
    let context = node.provider.as_ref().and_then(|p| p.get_context());

    for item in node.children.iter_mut() {
        let inactive = *context
            .and_then(|c| c.inactive_nodes_map.as_ref().and_then(|m| m.get(&item.id)))
            .unwrap_or(&false);

        if inactive {
            continue;
        }

        item.draw(pixmap, context);

        if let Some(provider) = item.provider.as_mut() {
            provider.set_context(pixmap, node.provider.as_ref());

            // 这段感觉放这有点重，想搬走
            // match provider {
            //     soft_skia::shape::Providers::G(group) => {
            //         if let Some(clip) = &group.clip {
            //             if let Some(clip_id) = clip.id {
            //                 if let Some(clip_path) =
            //                     item.children.iter_mut().find(|n| n.id == clip_id).and_then(
            //                         |n| Some(n.shape.get_path(group.context.as_ref().unwrap())),
            //                     )
            //                 {
            //                     group.set_context_mask(pixmap, &clip_path);
            //                 }
            //             }
            //         }
            //     }
            // }
        }

        recursive_rasterization_node_to_pixmap(item, pixmap);
    }
    if let Some(context) = context {
        if let Some(mask) = &context.mask {
            pixmap.apply_mask(mask)
        }
    }
}

#[cfg(test)]
mod test {
    extern crate soft_skia;
    use soft_skia::instance::Instance;
    use soft_skia::shape::PaintStyle;
    use soft_skia::shape::Rect;
    use soft_skia::shape::Shapes;
    use super::to_base64;

    #[test]
    fn test_set_shape() {
        let mut instance = Instance::new(0);
        assert_eq!(
            instance.get_tree_node_by_id(0).unwrap().get_children_len(),
            0
        );

        instance.create_child_append_to_container(1, 0);
        assert_eq!(
            instance.get_tree_node_by_id(0).unwrap().get_children_len(),
            1
        );

        match instance.get_tree_node_by_id(1).unwrap().shape {
            Shapes::R(Rect {
                x,
                y,
                width,
                height,
                color,
                style,
            }) => {
                assert_eq!(x, 0);
                assert_eq!(y, 0);
            }
            _ => {
                panic!()
            }
        }

        instance.set_shape_to_child(
            0,
            Shapes::R(Rect {
                x: 0,
                y: 0,
                width: 400,
                height: 400,
                color: Some(soft_skia::shape::ColorU8::from_rgba(0, 0, 0, 255)),
                style: None,
            }),
        );

        instance.set_shape_to_child(
            1,
            Shapes::R(Rect {
                x: 20,
                y: 20,
                width: 200,
                height: 200,
                color: Some(soft_skia::shape::ColorU8::from_rgba(0, 100, 0, 255)),
                style: None,
            }),
        );

        match instance.get_tree_node_by_id(1).unwrap().shape {
            Shapes::R(Rect {
                x,
                y,
                width,
                height,
                color,
                style,
            }) => {
                assert_eq!(x, 20);
                assert_eq!(y, 20);
                assert_eq!(width, 200);
                assert_eq!(height, 200);
                assert_eq!(color.unwrap().green(), 100);
            }
            _ => {
                panic!()
            }
        }

        let b64 = to_base64(&mut instance.tree);

        println!("{}", b64);
        assert_eq!(b64.len() > 0, true);

    }

}

