layout={
  main={
    LinearLayout,
    layout_width="fill",
    layout_height="fill",
    orientation="vertical";
    {
      HorizontalScrollView;
      --   layout_marginTop="3dp";
      layout_width="-1";
      layout_height="wrap";
      horizontalScrollBarEnabled=false;
      {
        LinearLayout;
        orientation="horizontal";
        layout_height="-2";
        gravity="center";
        layout_width="wrap";
        id="spq2",
      };
    };
  
    {
      FrameLayout;
      layout_height="wrap";
      -- layout_marginTop="80dp";
      layout_width="-1";
      {
        HorizontalListView;
        --    layout_marginTop="3dp";
        id="spq2";
        layout_height="wrap";
        horizontalScrollBarEnabled=false;
      };
    };

    {
      LuaEditor,
      id="editor",
      text="",
      layout_width="fill",
      layout_height="fill",
      layout_weight=1 ,
      --gravity="top"
    },
    {
      HorizontalScrollView;
      horizontalScrollBarEnabled=false,
      {
        LinearLayout;
        id="ps_bar";
        layout_width="fill";
      };
      layout_width="fill";
    };
  },
}
