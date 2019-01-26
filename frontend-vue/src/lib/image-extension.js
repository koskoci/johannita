/* eslint-disable */
import { Node, Plugin } from 'tiptap';

export default class ImageExtension extends Node {
  get name() {
    return 'image_ext';
  }

  get schema() {
    return {
      inline: true,
      attrs: {
        src: {},
        alt: {
          default: null,
        },
        title: {
          default: null,
        },
        height: {
          default: null,
        },
        width:{
          default: '200',
        },
        class:{
          default: 'content-image-left'
        }
      },
      group: 'inline',
      draggable: true,
      parseDOM: [
        {
          tag: 'img[src]',
          getAttrs: dom => ({
            src: dom.getAttribute('src'),
            title: dom.getAttribute('title'),
            alt: dom.getAttribute('alt'),
            width: dom.getAttribute('width'),
            height: dom.getAttribute('height'),
            class: dom.getAttribute('class'),
          }),
        },
      ],
      toDOM: node => ['img', node.attrs],
    };
  }

  commands({ type }) {
    return attrs => (state, dispatch) => {
      const { selection } = state;
      const position = selection.$cursor ? selection.$cursor.pos : selection.$to.pos;
      const node = type.create(attrs);
      const transaction = state.tr.insert(position, node);
      dispatch(transaction);
    };
  }

  // get plugins() {
  //   return [
  //     new Plugin({
  //       props: {
  //         handleDOMEvents: {
  //           drop(view, event) {
  //             const hasFiles = event.dataTransfer
  //               && event.dataTransfer.files
  //               && event.dataTransfer.files.length;
  //
  //             if (!hasFiles) {
  //               return;
  //             }
  //
  //             const images = Array
  //               .from(event.dataTransfer.files)
  //               .filter(file => (/image/i).test(file.type));
  //
  //             if (images.length === 0) {
  //               return;
  //             }
  //
  //             event.preventDefault();
  //
  //             const { schema } = view.state;
  //             const coordinates = view.posAtCoords({ left: event.clientX, top: event.clientY });
  //
  //             images.forEach((image) => {
  //               const reader = new FileReader();
  //
  //               reader.onload = (readerEvent) => {
  //                 const node = schema.nodes.image.create({
  //                   src: readerEvent.target.result,
  //                 });
  //                 const transaction = view.state.tr.insert(coordinates.pos, node);
  //                 view.dispatch(transaction);
  //               };
  //               reader.readAsDataURL(image);
  //             });
  //           },
  //         },
  //       },
  //     }),
  //   ];
  // }
}
