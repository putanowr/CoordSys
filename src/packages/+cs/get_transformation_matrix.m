function Q = get_transformation_matrix(fromCS, toCS)
  Q = toCS.orientation'* fromCS.orientation;
end
