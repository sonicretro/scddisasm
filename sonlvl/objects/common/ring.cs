using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Drawing;
using SonicRetro.SonLVL.API;
using SonicRetro.SonLVL.API.SCD;

namespace SCDObjectDefinitions.Common
{
	public class Ring : ObjectDefinition
	{
		private Size[] Spacing = {
			new Size(0x10, 0),
			new Size(0x18, 0),
			new Size(0x20, 0),
			new Size(0, 0x10),
			new Size(0, 0x18),
			new Size(0, 0x20),
			new Size(0x10, 0x10),
			new Size(0x18, 0x18),
			new Size(0x20, 0x20),
			new Size(-0x10, 0x10),
			new Size(-0x18, 0x18),
			new Size(-0x20, 0x20),
			new Size(0x10, 8),
			new Size(0x18, 0x10),
			new Size(-0x10, 8),
			new Size(-0x18, 0x10)
		};

		private Sprite img_low;
		private Sprite img_high;

		public override void Init(ObjectData data)
		{
			byte[] art_file = ObjectHelper.OpenArtFile("../src/gfx/ring.nem", CompressionType.Nemesis);
			img_low = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/ring.asm", 0, 1, false);
			img_high = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/ring.asm", 0, 1, true);
		}

		public override ReadOnlyCollection<byte> Subtypes
		{
			get { return new ReadOnlyCollection<byte>(new List<byte>()); }
		}

		public override string Name
		{
			get { return "Ring"; }
		}

		public override bool RememberState
		{
			get { return true; }
		}

		public override string SubtypeName(byte subtype)
		{
			return string.Empty;
		}

		public override Sprite Image
		{
			get { return img_low; }
		}

		public override Sprite SubtypeImage(byte subtype)
		{
			return img_low;
		}

		public override Sprite GetSprite(ObjectEntry obj)
		{
			int count = Math.Min(6, obj.SubType & 7) + 1;
			Size space = Spacing[obj.SubType >> 4];
			List<Sprite> sprs = new List<Sprite>();
			Point loc = new Point();

			for (int i = 0; i < count; i++)
			{
				Sprite tmp;
				if (LevelData.Level.Zone == 6 && ((SCDObjectEntry)obj).SubType2 != 0)
					tmp = new Sprite(img_low);
				else
					tmp = new Sprite(img_high);
				tmp.Offset(loc);
				sprs.Add(tmp);
				loc += space;
			}

			return new Sprite(sprs.ToArray());
		}
		
		public override int GetDepth(ObjectEntry obj)
		{
			if (LevelData.Level.Zone == 6 && ((SCDObjectEntry)obj).SubType2 == 0)
				return 0;
			return 2;
		}

		private PropertySpec[] custom_properties = new PropertySpec[] {
			new PropertySpec("Count", typeof(int), "Extended", "The number of rings.", null,
				(obj) => { return Math.Min(6, obj.SubType & 7) + 1; },
				(obj, value) => obj.SubType = (byte)((obj.SubType & ~7) | (Math.Min((int)value, 7) - 1))),

			new PropertySpec("Direction", typeof(int), "Extended", "The direction of ring placement.", null, new Dictionary<string, int>()
				{
					{ "Right (Short)", 0x00 },
					{ "Right (Medium)", 0x01 },
					{ "Right (Far)", 0x02 },
					{ "Down (Short)", 0x03 },
					{ "Down (Medium)", 0x04 },
					{ "Down (Far)", 0x05 },
					{ "Down-Right (Short)", 0x06 },
					{ "Down-Right (Medium)", 0x07 },
					{ "Down-Right (Far)", 0x08 },
					{ "Down-Left (Short)", 0x09 },
					{ "Down-Left (Medium)", 0x0A },
					{ "Down-Left (Far)", 0x0B },
					{ "Down-Right-Right (Short)", 0x0C },
					{ "Down-Right-Right (Medium)", 0x0D },
					{ "Down-Left-Left (Short)", 0x0E },
					{ "Down-Left-Left (Medium)", 0x0F }
				},
				(obj) => { return (obj.SubType >> 4) & 0xF; },
				(obj, value) => obj.SubType = (byte)((obj.SubType & ~0xF0) | (((int)value & 0xF) << 4))),

			new PropertySpec("Back Layer", typeof(bool), "Extended", "If true, the rings are placed on the back layer (Metallic Madness only).", null,
				(obj) => { return (((SCDObjectEntry)obj).SubType2 & 0x01) == 0x01; },
				(obj, value) => ((SCDObjectEntry)obj).SubType2 = (byte)((((SCDObjectEntry)obj).SubType2 & ~0x01) | ((bool)value ? 0x01 : 0x00)))
		};

		public override PropertySpec[] CustomProperties
		{
			get { return custom_properties; }
		}
	}
}
