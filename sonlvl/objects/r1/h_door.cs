using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Drawing;
using SonicRetro.SonLVL.API;
using SonicRetro.SonLVL.API.SCD;

namespace SCDObjectDefinitions.R1
{
	public class HDoor : ObjectDefinition
	{
		private Sprite img;

		public override void Init(ObjectData data)
		{
			byte[] art_file = ObjectHelper.OpenArtFile("../src/gfx/r1/door.nem", CompressionType.Nemesis);
			img = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r1/h_door.asm", 0, 0, true);
		}

		public override ReadOnlyCollection<byte> Subtypes
		{
			get { return new ReadOnlyCollection<byte>(new byte[] { 0, 1, 2 }); }
		}

		public override string Name
		{
			get
			{
				if (LevelData.Level.Zone != 0)
					return "Door (Horizontal, Palmtree Panic)";
				return "Door (Horizontal)";
			}
		}

		public override bool RememberState
		{
			get { return false; }
		}

		public override string SubtypeName(byte subtype)
		{
			string[] names = {
				"Splash (44px Wide)",
				"No Splash (44px Wide)",
				"No Splash (24px Wide)"
			};
			return names[subtype];
		}

		public override Sprite Image
		{
			get { return img; }
		}

		public override Sprite SubtypeImage(byte subtype)
		{
			return img;
		}

		public override Sprite GetSprite(ObjectEntry obj)
		{
			return new Sprite(img, obj.XFlip, obj.YFlip);
		}
		
		public override int GetDepth(ObjectEntry obj)
		{
			return 1;
		}
	}
}
