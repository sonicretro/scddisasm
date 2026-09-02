using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Drawing;
using SonicRetro.SonLVL.API;
using SonicRetro.SonLVL.API.SCD;

namespace SCDObjectDefinitions.R1
{
	public class Boulder : ObjectDefinition
	{
		private Sprite img;

		public override void Init(ObjectData data)
		{
			byte[] art_file = ObjectHelper.OpenArtFile("../src/gfx/r1/boulder.nem", CompressionType.Nemesis);
			img = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r1/boulder.asm", 0, 0);
		}

		public override ReadOnlyCollection<byte> Subtypes
		{
			get { return new ReadOnlyCollection<byte>(new List<byte>()); }
		}

		public override string Name
		{
			get { return (LevelData.Level.Zone == 0) ? "Boulder" : "Boulder (Palmtree Panic)"; }
		}

		public override bool RememberState
		{
			get { return false; }
		}

		public override string SubtypeName(byte subtype)
		{
			return string.Empty;
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
			return 4;
		}
	}
}
