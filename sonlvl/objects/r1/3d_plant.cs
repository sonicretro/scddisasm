using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Drawing;
using SonicRetro.SonLVL.API;
using SonicRetro.SonLVL.API.SCD;

namespace SCDObjectDefinitions.R1
{
	public class Plant3D : ObjectDefinition
	{
		private int[] offsets_front = {
			0x40,
			0x80,
			-0x40,
			-0x80
		};
		private int[] offsets_back = {
			0x00,
			0x60,
			-0x60
		};

		private Sprite img_front;
		private Sprite img_back;


		public override void Init(ObjectData data)
		{
			byte[] art_file = ObjectHelper.OpenArtFile("../src/gfx/r1/3d_plant.nem", CompressionType.Nemesis);
			img_front = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r1/3d_plant.asm", 0, 2);
			img_back = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r1/3d_plant.asm", 1, 2);
		}

		public override ReadOnlyCollection<byte> Subtypes
		{
			get { return new ReadOnlyCollection<byte>(new byte[] { 0, 1 }); }
		}

		public override string Name
		{
			get { return "3D Plant"; }
		}

		public override bool RememberState
		{
			get { return false; }
		}

		public override string SubtypeName(byte subtype)
		{
			return (((subtype & 1) != 0) ? 2 : 4) + " foreground plants";
		}

		public override Sprite Image
		{
			get { return img_front; }
		}

		public override Sprite SubtypeImage(byte subtype)
		{
			return img_front;
		}

		public override Sprite GetSprite(ObjectEntry obj)
		{
			List<Sprite> sprs = new List<Sprite>();
			int fg_count = ((obj.SubType & 1) != 0) ? 2 : 4;
			int bg_count = 3;

			for (int i = bg_count - 1; i >= 0; i--)
			{
				Sprite tmp = new Sprite(img_back);

				Point loc = new Point();
				loc.X += offsets_back[i];
				tmp.Offset(loc);

				sprs.Add(tmp);
			}

			for (int i = fg_count - 1; i >= 0; i--)
			{
				Sprite tmp = new Sprite(img_front);

				Point loc = new Point();
				loc.X += offsets_front[i];
				tmp.Offset(loc);

				sprs.Add(tmp);
			}

			return new Sprite(sprs.ToArray());
		}
		
		public override int GetDepth(ObjectEntry obj)
		{
			return 0;
		}
	}
}
