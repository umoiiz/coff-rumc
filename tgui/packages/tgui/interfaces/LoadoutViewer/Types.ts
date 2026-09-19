import { Loadout } from '../LoadoutManager/Types';

export type LoadoutViewerData = {
  items: Record<keyof typeof SLOTS, LoadoutSlotItem>;
  loadout: Loadout;
};

export type LoadoutSlotItem = {
  icons: LoadoutIconInfo[];
  name: string;
};

export type LoadoutIconInfo = {
  icon: string;
  translateX: string;
  translateY: string;
  scale: number;
};

export type LoadoutSlotData = {
  items: Record<keyof typeof SLOTS, LoadoutSlotItem>;
};

export const getGridSpotKey = (spot: [number, number]): GridSpotKey => {
  return `${spot[0]}/${spot[1]}`;
};

export const SLOTS: Record<
  string,
  {
    displayName: string;
    gridSpot: GridSpotKey;
    image?: string;
  }
> = {
  slot_glasses: {
    displayName: '眼镜',
    gridSpot: getGridSpotKey([0, 0]),
    image: 'inventory-glasses.png',
  },

  slot_head: {
    displayName: '头饰',
    gridSpot: getGridSpotKey([0, 1]),
    image: 'inventory-head.png',
  },

  slot_wear_mask: {
    displayName: '面罩',
    gridSpot: getGridSpotKey([0, 2]),
    image: 'inventory-mask.png',
  },

  slot_w_uniform: {
    displayName: '制服',
    gridSpot: getGridSpotKey([1, 0]),
    image: 'inventory-uniform.png',
  },

  slot_suit: {
    displayName: '护甲',
    gridSpot: getGridSpotKey([1, 1]),
    image: 'inventory-suit.png',
  },

  slot_gloves: {
    displayName: '手套',
    gridSpot: getGridSpotKey([1, 2]),
    image: 'inventory-gloves.png',
  },

  slot_belt: {
    displayName: '腰带',
    gridSpot: getGridSpotKey([2, 0]),
    image: 'inventory-belt.png',
  },

  slot_shoes: {
    displayName: '鞋子',
    gridSpot: getGridSpotKey([2, 1]),
    image: 'inventory-shoes.png',
  },

  slot_s_store: {
    displayName: '护甲存储物品',
    gridSpot: getGridSpotKey([2, 2]),
    image: 'inventory-suit_storage.png',
  },

  slot_back: {
    displayName: '背部',
    gridSpot: getGridSpotKey([3, 0]),
    image: 'inventory-back.png',
  },

  slot_l_store: {
    displayName: '左口袋',
    gridSpot: getGridSpotKey([3, 1]),
    image: 'inventory-pocket.png',
  },

  slot_r_store: {
    displayName: '右口袋',
    gridSpot: getGridSpotKey([3, 2]),
    image: 'inventory-pocket.png',
  },
};

export type GridSpotKey = string;
