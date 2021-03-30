
# group_image processing

  has_many :member_images
  has_many_attached :group_images

group_image are upload in group_image view as mutiple group.

Once they are uploaded, member images are created for each image attachment.

member_images does not have active_storage attchments, they just refer to the given image_path by group_image
Each member_image role is 

1. to edit caption for each attachemnt
2. save order value for position change
3. delete attached image
4. crop attached image

## adding new member image

adding new images to group_image is done from group_image?

## deleting member image

delete attached image is done from member_image

## cropping member image


** problem 

There seems to be a problem!
When group_image is placed with in article, 
it has to be placed with fit_type of ignoring width to height ratio
or chopped on right or left side.

solution?
we may have to layout member images and captions at the time of layout,
after deciding the size of the group_image and member_images.
meaning, not to make group_image before hand and placing as single image,
like we are doing 

