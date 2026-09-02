using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Drawing;
using SonicRetro.SonLVL.API;
using SonicRetro.SonLVL.API.SCD;

namespace SCDObjectDefinitions.R1
{
	public class LogInside : ObjectDefinition
	{
		private Sprite[] img;

		public override void Init(ObjectData data)
		{
			byte[] art_file;
			if (LevelData.Level.TimeZone != SonicRetro.SonLVL.API.TimeZone.Future)
				art_file = ObjectHelper.OpenArtFile("../src/gfx/r1/log_inside_ab.nem", CompressionType.Nemesis);
			else
				art_file = ObjectHelper.OpenArtFile("../src/gfx/r1/log_inside_cd.nem", CompressionType.Nemesis);

			img = new Sprite[2];
			img[0] = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r1/log_inside.asm", 0, 2);
			img[1] = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r1/log_inside.asm", 1, 2);
		}

		public override ReadOnlyCollection<byte> Subtypes
		{
			get { return new ReadOnlyCollection<byte>(new byte[] { 0, 1 }); }
		}

		public override string Name
		{
			get { return "Log Inside"; }
		}

		public override bool RememberState
		{
			get { return false; }
		}

		public override byte DefaultSubtype
		{
			get { return (byte)((LevelData.Level.TimeZone != SonicRetro.SonLVL.API.TimeZone.Future) ? 0 : 1); }
		}

		public override string SubtypeName(byte subtype)
		{
			switch (subtype)
			{
				case 0:
					return "Present/Past";

				case 1:
					return "Future";
			}
			return string.Empty;
		}

		public override Sprite Image
		{
			get { return img[DefaultSubtype]; }
		}

		public override Sprite SubtypeImage(byte subtype)
		{
			if (subtype < img.Length)
				return img[subtype];
			return ObjectHelper.UnknownObject;
		}

		public override Sprite GetSprite(ObjectEntry obj)
		{
			return new Sprite(SubtypeImage(obj.SubType), obj.XFlip, obj.YFlip);
		}
		
		public override int GetDepth(ObjectEntry obj)
		{
			return 6;
		}
	}
}
