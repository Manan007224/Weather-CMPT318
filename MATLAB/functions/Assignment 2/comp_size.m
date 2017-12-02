function numPixels = comp_size(img) % returns array of sizes of each connected component

cc = bwconncomp(img);
pl = cc.PixelIdxList;
numPixels = cellfun(@numel,pl);

end