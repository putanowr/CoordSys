function R = get_transformation_matrix(fromCS, toCS)
  R = fromCS.orientation'* toCS.orientation;
end
