"""Helper functions for image preprocessing."""

from __future__ import absolute_import
from __future__ import division
from __future__ import print_function


import tensorflow as tf


def distort_image(image):
  """Perform random distortions on an image.

  Args:
    image: A float32 Tensor of shape [height, width, 3] with values in [0, 1).
    
  Returns:
    distorted_image: A float32 Tensor of shape [height, width, 3] with values in
      [0, 1].
  """
  # Randomly flip horizontally. No color distortion.
  with tf.name_scope("flip_horizontal", values=[image]):
    image = tf.image.random_flip_left_right(image)

  return image


def process_image(encoded_image,
                  is_training,
                  height,
                  width,
                  resize_height=299,
                  resize_width=299,
                  image_format="jpeg",
                  image_idx=0):
  """Decode an image, resize and apply random distortions.

  Args:
    encoded_image: String Tensor containing the image.
    is_training: Boolean; whether preprocessing for training or eval.
    height: Height of the output image.
    width: Width of the output image.
    resize_height: If > 0, resize height before crop to final dimensions.
    resize_width: If > 0, resize width before crop to final dimensions.
    image_format: "jpeg" or "png".
    image_idx: image index of the image in an outfit.
  Returns:
    A float32 Tensor of shape [height, width, 3] with values in [-1, 1].

  Raises:
    ValueError: If image_format is invalid.
  """
  # Helper function to log an image summary to the visualizer. Summaries are
  # only logged in thread 0.
  def image_summary(name, image):
    tf.image_summary(name, tf.expand_dims(image, 0))

  # Decode image into a float32 Tensor of shape [?, ?, 3] with values in [0, 1).
  with tf.name_scope("decode", values=[encoded_image]):
    if image_format == "jpeg":
      image = tf.image.decode_jpeg(encoded_image, channels=3)
    elif image_format == "png":
      image = tf.image.decode_png(encoded_image, channels=3)
    else:
      raise ValueError("Invalid image format: %s" % image_format)
  image = tf.image.convert_image_dtype(image, dtype=tf.float32)
  image_summary("original_image/" + str(image_idx), image)

  # Resize image.
  assert (resize_height > 0) == (resize_width > 0)
  if resize_height:
    image = tf.image.resize_images(image,
                                   size=[resize_height, resize_width],
                                   method=tf.image.ResizeMethod.BILINEAR)

  # Crop to final dimensions. In the Polyvore model, no cropping is used
  # since we set height=resize_height and width=resize_width
  if is_training:
    image = tf.random_crop(image, [height, width, 3])
  else:
    image = tf.image.resize_image_with_crop_or_pad(image, height, width)

  image_summary("resized_image/" + str(image_idx), image)

  # Randomly distort the image.
  if is_training:
    image = distort_image(image)

  image_summary("final_image/" + str(image_idx), image)

  # Rescale to [-1,1] instead of [0, 1]
  image = tf.sub(image, 0.5)
  image = tf.mul(image, 2.0)
  return image